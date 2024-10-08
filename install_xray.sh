#!/bin/bash

# Определение домашних папок и путей
USER_HOME=$(eval echo ~$SUDO_USER)
CONFIG_FILE="/usr/local/etc/xray/config.json"
USER_CONFIG_FILE="$USER_HOME/xray_config.json"
USER_DATA_FILE="$USER_HOME/xray_user_data.txt"
CLIENT_LINKS_FILE="$USER_HOME/xray_client_links.txt"
USER_DIR="$USER_HOME/xray_users"
USER_LINKS_FILE="$USER_HOME/xray_user_links.txt"
IPTABLES_RULES_FILE="$USER_HOME/iptables_rules.txt"

	# Установка обновлений
echo "Установка обновлений Linux и необходимых пакетов"	
apt-get update -y && apt-get upgrade && apt-get dist-upgrade
#apt-get install -y jq unzip curl libsodium-dev

# Установка Xray
#echo "Устанавливаем Xray..."
#bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install

# Функция для установки Xray
echo "Установка Xray..."
install_xray() {
		
	# Удаление старых версий Xray
	if command -v xray >/dev/null 2>&1; then
		echo "Xray уже установлен. Удаляем старую версию..."
		apt-get remove --purge xray -y
	fi

	# Загрузка и установка Xray
	bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install

	# Создание необходимой директории
	mkdir -p /usr/local/etc/xray
	
	# Установка необходимых зависимостей
	apt-get update
	apt-get install -y jq unzip curl libsodium-dev
	echo "Xray успешно установлен."
}

# Основная часть скрипта
install_xray  # Вызов функции установки Xray

# Функция для генерации UUID
generate_uuid() {
	uuidgen
}

# Функция для генерации ключей X25519
generate_x25519_keys() {
	# Проверка наличия команды xray x25519
	if command -v xray >/dev/null 2>&1; then
		keys=$(xray x25519)
		private_key=$(echo "$keys" | grep "Private key" | awk '{print $3}')
		public_key=$(echo "$keys" | grep "Public key" | awk '{print $3}')
	else
		echo "Команда xray x25519 не найдена. Используйте альтернативный метод генерации ключей."
		exit 1
	fi
}

# Функция для генерации случайного пароля в формате Base64
generate_base64_key() {
	openssl rand -base64 16
}

# Функция для генерации короткого ID
generate_short_id() {
	uuidgen | cut -d'-' -f1
}

# Список популярных сайтов для маскировки
sites=(
	"example.com"
	"wikipedia.org"
	"github.com"
	"stackoverflow.com"
	"reddit.com"
	"imdb.com"
	"nytimes.com"
	"bloomberg.com"
	"cnn.com"
	"techcrunch.com"
)

# Функция для отображения списка сайтов
display_sites() {
	echo "Выберите сайт для подмены (введите цифру от 1 до ${#sites[@]}, или 0 для ввода собственного):"
	for i in "${!sites[@]}"; do
		echo "$((i + 1)). ${sites[$i]}"
	done
	echo "0. Ввести свой собственный домен"
}

# Запрос ввода данных у пользователя
read -p "Введите IP-адрес вашего сервера: " server_ip
display_sites
read -p "Ваш выбор: " choice

# Определение маскировочного домена
case $choice in
	[1-9]|10)
		camouflage_domain="${sites[$((choice - 1))]}"
		;;
	0)
		read -p "Введите маскировочный домен (например, example.com): " camouflage_domain
		;;
	*)
		echo "Некорректный выбор. Пожалуйста, выберите цифру от 0 до ${#sites[@]}."
		exit 1
		;;
esac

# Запрос остальных данных
read -p "Введите путь для WebSocket (например, mypath): " path

# Генерация ключей и UUID
echo "Генерация ключей и UUID..."
generate_x25519_keys
user_uuid=$(generate_uuid)
ss_password=$(generate_base64_key)
short_id=$(generate_short_id)

# Вывод для проверки
echo "Private Key: $private_key"
echo "Public Key: $public_key"
echo "UUID: $user_uuid"
echo "Shadowsocks Password: $ss_password"
echo "Shadowsocks Password: $short_id"

# Запрос порта для Shadowsocks
read -p "Введите порт для Shadowsocks (например, 54321): " ss_port

# Запрос на изменение порта SSH
read -p "Хотите изменить порт SSH? (y/n): " change_ssh_port
if [[ "$change_ssh_port" == "y" ]]; then
	read -p "Введите новый порт для SSH (например, 2222): " ssh_port
	
	# Проверка, что порт не занят
	if netstat -tuln | grep -q ":$ssh_port "; then
		echo "Ошибка: Порт $ssh_port уже используется."
		exit 1
	fi

	# Изменение порта SSH
	echo "Изменение порта SSH на $ssh_port..."
	sudo sed -i "s/^#Port 22/Port $ssh_port/" /etc/ssh/sshd_config
	sudo sed -i "s/^Port 22/Port $ssh_port/" /etc/ssh/sshd_config
	sudo systemctl restart sshd
	echo "Порт SSH успешно изменен на $ssh_port."
fi

# Запрос на добавление пользователей
read -p "Хотите добавить пользователей? (y/n): " add_users
if [[ "$add_users" == "y" ]]; then
	# Создание папки для пользователей
	mkdir -p "$USER_DIR"
	
# Инициализация переменной для хранения данных пользователей
	users_config=""
	
# Очистка файла ссылок для пользователей
	: > "$USER_LINKS_FILE"
	
# Очистка данных о клиентах перед добавлением новых
	: > "$CONFIG_FILE"
	
	while true; do
		# Ввод имени пользователя
		read -p "Введите имя пользователя (или оставьте пустым для завершения): " user_name
		
		if [[ -z "$user_name" ]]; then
			break
		fi
		
		# Генерация UUID для пользователя
		current_user_uuid=$(generate_uuid)
		
		# Добавление данных пользователя в конфигурацию
		users_config+=$(cat <<EOF
			{
			  "id": "$current_user_uuid",
			  "email": "$user_name"
			},
EOF
		)
		
		# Создание файла с данными пользователя
		user_file="$USER_DIR/${user_name}_data.txt"
		cat > "$user_file" <<EOF
	UUID: $current_user_uuid
	Private Key: $private_key
	Public Key: $public_key
	Shadowsocks Password: $ss_password
EOF
	
		echo "Данные для пользователя $user_name сохранены в $user_file"
		
		# Формирование ссылки для VLESS
		user_vless_link="vless://$current_user_uuid@$server_ip:443/?encryption=none&type=tcp&sni=$camouflage_domain&fp=chrome&security=reality&alpn=h2&flow=xtls-rprx-vision&pbk=$public_key&packetEncoding=xudp"
		# Формирование ссылки для Shadowsocks
		user_ss_link="ss://2022-blake3-aes-128-gcm:$ss_password@$server_ip:$ss_port"
		
		# Запись ссылок в файл
		echo "VLESS Link for $user_name: $user_vless_link" >> "$USER_LINKS_FILE"
		echo "Shadowsocks Link for $user_name: $user_ss_link" >> "$USER_LINKS_FILE"
	
		# Сохранение конфигурации клиента в отдельный JSON-файл
		client_config_file="$USER_DIR/${user_name}_config.json"
		cat > "$client_config_file" <<EOF
	{
	  "log": {
		"access": "none",
		"error": "",
		"loglevel": "warning",
		"dnsLog": false
	  },
	  "stats": {},
	  "policy": {
		"levels": {
		  "0": {
			"statsUserUplink": true,
			"statsUserDownlink": true
		  }
		},
		"system": {
		  "statsOutboundUplink": true,
		  "statsOutboundDownlink": true
		}
	  },
	  "api": {
		"tag": "api",
		"services": [
		  "StatsService"
		]
	  },
	  "inbounds": [
		{
		  "listen": "127.0.0.1",
		  "port": 8080,
		  "protocol": "dokodemo-door",
		  "settings": {
			"address": "127.0.0.1"
		  },
		  "tag": "api"
		},
		{
		  "tag": "socks",
		  "port": 800,
		  "listen": "127.0.0.1",
		  "protocol": "socks",
		  "sniffing": {
			"enabled": true,
			"destOverride": [
			  "http",
			  "tls"
			],
			"routeOnly": true
		  },
		  "settings": {
			"auth": "noauth",
			"udp": true
		  }
		},
		{
		  "tag": "http",
		  "port": 801,
		  "listen": "127.0.0.1",
		  "protocol": "http",
		  "sniffing": {
			"enabled": true,
			"destOverride": [
			  "http",
			  "tls"
			],
			"routeOnly": true
		  },
		  "settings": {
			"auth": "noauth",
			"udp": true
		  }
		}
	  ],
	  "outbounds": [
		{
		  "tag": "proxy",
		  "protocol": "vless",
		  "settings": {
			"vnext": [
			  {
				"address": "$server_ip",
				"port": 443,
				"users": [
				  {
					"id": "$current_user_uuid",
					"email": "$user_name",
					"encryption": "none",
					"flow": "xtls-rprx-vision"
				  }
				]
			  }
			]
		  },
		  "streamSettings": {
			"network": "tcp",
			"security": "reality",
			"realitySettings": {
			  "fingerprint": "chrome",
			  "serverName": "$camouflage_domain",
			  "show": false,
			  "publicKey": "$public_key",
			  "shortId": "$short_id"
			}
		  }
		},
		{
		  "tag": "direct",
		  "protocol": "freedom",
		  "settings": {}
		},
		{
		  "protocol": "blackhole",
		  "tag": "block"
		}
	  ],
	  "routing": {
		"domainStrategy": "AsIs",
		"rules": [
		  {
			"type": "field",
			"inboundTag": [
			  "api"
			],
			"outboundTag": "api"
		  },
		  {
			"type": "field",
			"network": "udp",
			"outboundTag": "direct"
		  },
		  {
			"type": "field",
			"ip": [
			  "geoip:private"
			],
			"outboundTag": "block"
		  },
		  {
			"type": "field",
			"protocol": [
			  "bittorrent"
			],
			"outboundTag": "direct"
		  },
		  {
			"type": "field",
			"port": "6969,6881-6889",
			"outboundTag": "direct"
		  },
		  {
			"type": "field",
			"sourcePort": "6881-6889",
			"outboundTag": "direct"
		  },
		  {
			"type": "field",
			"domain": [
			  "ext:customgeo.dat:coherence-extra-exceptions"
			],
			"outboundTag": "proxy"
		  },
		  {
			"type": "field",
			"domain": [
			  "geosite:cn",
			  "domain:cn",
			  "domain:xn--fiqs8s",
			  "domain:xn--fiqz9s",
			  "domain:xn--55qx5d",
			  "domain:xn--io0a7i",
			  "domain:ru",
			  "domain:xn--p1ai",
			  "domain:by",
			  "domain:xn--90ais",
			  "domain:ir",
			  "ext:customgeo.dat:coherence-extra",
			  "ext:customgeo.dat:coherence-extra-plus"
			],
			"outboundTag": "direct"
		  },
		  {
			"type": "field",
			"ip": [
			  "geoip:cn",
			  "geoip:ru",
			  "geoip:by",
			  "geoip:ir"
			],
			"outboundTag": "direct"
		  }
		]
	  }
	}
EOF
	
		echo "Конфигурация клиента сохранена в $client_config_file"
	done
	
	# Удаление последней запятой и добавление закрывающей скобки
	users_config=$(echo "$users_config" | sed '$ s/,$//')
	  fi
	  
	  # Создание конфигурационного файла Xray
	  cat > $CONFIG_FILE <<EOF
	  {
		"log": {
		  "loglevel": "info"
		},
		"inbounds": [
		  {
			"listen": "$server_ip",
			"port": 443,
			"protocol": "vless",
			"tag": "reality-in",
			"settings": {
			  "clients": [
				$users_config
			  ],
			  "decryption": "none"
			},
			"streamSettings": {
			  "network": "tcp",
			  "security": "reality",
			  "realitySettings": {
				"show": false,
				"dest": "$camouflage_domain:443",
				"xver": 0,
				"serverNames": [
				  "$camouflage_domain"
				],
				"privateKey": "$private_key",
				"minClientVer": "",
				"maxClientVer": "",
				"maxTimeDiff": 0,
				"shortIds": [""]
			  }
			},
			"sniffing": {
			  "enabled": true,
			  "destOverride": [
				"http",
				"tls",
				"quic"
			  ]
			}
		  },
		  {
			"port": $ss_port,
			"tag": "ss-in",
			"protocol": "shadowsocks",
			"settings": {
			  "method": "2022-blake3-aes-128-gcm",
			  "password": "$ss_password",
			  "network": "tcp,udp"
			},
			"sniffing": {
			  "enabled": true,
			  "destOverride": [
				"http",
				"tls",
				"quic"
			  ]
			}
		  }
		],
		"outbounds": [
		  {
			"protocol": "freedom",
			"tag": "direct"
		  },
		  {
			"protocol": "blackhole",
			"tag": "block"
		  }
		],
		"routing": {
		  "rules": [
			{
			  "type": "field",
			  "protocol": "bittorrent",
			  "outboundTag": "block"
			}
		  ],
		  "domainStrategy": "IPIfNonMatch"
		}
	  }
EOF
	  
	  # Копирование конфигурационного файла в домашнюю папку пользователя
	  cp "$CONFIG_FILE" "$USER_CONFIG_FILE"
	  
	  # Генерация и сохранение всех ссылок в файл
	  cat > "$CLIENT_LINKS_FILE" <<EOF
	  VLESS Link: vless://$user_uuid@$server_ip:443/?encryption=none&type=tcp&sni=$camouflage_domain&fp=chrome&security=reality&alpn=h2&flow=xtls-rprx-vision&pbk=$public_key&packetEncoding=xudp
	  Shadowsocks Link: ss://2022-blake3-aes-128-gcm:$ss_password@$server_ip:$ss_port
EOF
	  
	  # Применение настроек iptables
	  echo "Настройка iptables..."
	  iptables -A INPUT -p tcp --dport 443 -j ACCEPT
	  iptables -A INPUT -p tcp --dport $ss_port -j ACCEPT
	  iptables -A INPUT -p tcp --dport 22 -j ACCEPT
	  iptables -A INPUT -j DROP
	  iptables-save > "$IPTABLES_RULES_FILE"
	  echo "Правила iptables сохранены в $IPTABLES_RULES_FILE"
	  
	  # Перезапуск Xray после изменения конфигурации
	  systemctl restart xray
	  echo "Конфигурация Xray обновлена."
	  
	  # Применение новых настроек системного уровня
	  echo -e "\nНастройка системных параметров..."
	  echo -e "net.core.default_qdisc=fq\nnet.ipv4.tcp_congestion_control=bbr" | sudo tee -a /etc/sysctl.conf
	  sudo sysctl -p
	  
	  echo -e "\nКонфигурация Xray успешно создана и применена!"
	  echo "IP-адрес сервера: $server_ip"
	  echo "Маскировочный домен: $camouflage_domain"
	  echo "Публичный ключ Realty": $public_key
	  echo "Приватный ключ Reality: $private_key"
	  echo "UUID пользователя: $user_uuid"
	  echo "Порт для Shadowsocks: $ss_port"
	  echo "Порт для SSH: ${ssh_port:-22}"
	  echo "Сохраненные конфигурационные файлы и ссылки:"
	  echo "Конфигурационный файл Xray: $USER_CONFIG_FILE"
	  echo "Файл с данными пользователя: $USER_DATA_FILE"
	  echo "Файл с ссылками для клиента: $CLIENT_LINKS_FILE"
	  echo "Файл с ссылками пользователей: $USER_LINKS_FILE"
	  echo "Файл с правилами iptables: $IPTABLES_RULES_FILE"