#!/bin/bash

# Определение домашней папки текущего пользователя
USER_HOME=$(eval echo ~$SUDO_USER)
# Путь к конфигурационному файлу Xray
CONFIG_FILE="/usr/local/etc/xray/config.json"
# Путь к конфигурационному файлу Xray в домашней папке пользователя
USER_CONFIG_FILE="$USER_HOME/xray_config.json"
# Путь для хранения данных пользователей
USER_DATA_FILE="$USER_HOME/xray_user_data.txt"
# Путь для хранения ссылок клиентов
CLIENT_LINKS_FILE="$USER_HOME/xray_client_links.txt"
# Путь для создания папки пользователей в корневой папке текущего пользователя
USER_DIR="$USER_HOME/xray_users"
# Путь для хранения ссылок пользователей
USER_LINKS_FILE="$USER_HOME/xray_user_links.txt"
# Путь для хранения правил iptables
IPTABLES_RULES_FILE="$USER_HOME/iptables_rules.txt"

# Создание необходимых директорий
mkdir -p "$USER_DIR"

# Функция для генерации нового UUID
generate_uuid() {
	xray uuid
}

# Функция для генерации ключей X25519
generate_x25519_keys() {
	xray x25519
}

# Функция для генерации случайного пароля в формате Base64
generate_base64_key() {
	openssl rand -base64 16
}

# Функция для создания файлов пользователя
create_user_files() {
	local user_name="$1"
	local user_uuid="$2"
	local user_private_key="$3"
	local user_public_key="$4"

	local user_folder="$USER_DIR/$user_name"
	mkdir -p "$user_folder"

	# Создание файла с данными пользователя
	cat > "$user_folder/user_data.txt" <<EOF
Имя пользователя: $user_name
UUID: $user_uuid
Приватный ключ: $user_private_key
Публичный ключ: $user_public_key
EOF

	echo "Файлы для пользователя $user_name созданы в $user_folder."
}

# Функция для создания конфигурационного файла клиента
create_client_config() {
	local user_name="$1"
	local user_uuid="$2"
	local public_key="$3"
	local ss_password="$4"

	# Получение IP-адреса сервера и домена для маскировки
	local server_ip=$(hostname -I | awk '{print $1}')
	local camouflage_domain="example.com"  # Укажите ваш домен или IP

	# Генерация короткого идентификатора
	local short_id=$(openssl rand -hex 4)

	# Путь к конфигурационному файлу клиента
	local client_config_file="$USER_DIR/${user_name}_config.json"

	# Конфигурация клиента в формате JSON
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
				"id": "$user_uuid",
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

	echo "Конфигурация клиента сохранена в $client_config_file."
}

# Функция для добавления нового пользователя в конфигурацию Xray
add_user() {
	local user_name="$1"
	local user_uuid="$2"
	local user_private_key="$3"
	local user_public_key="$4"
	local ss_password="$5"

	echo "Добавление пользователя $user_name с UUID $user_uuid..."

	# Обновление конфигурационного файла Xray
	jq --arg uuid "$user_uuid" --arg email "$user_name" \
		'.inbounds[0].settings.clients += [{"id": $uuid, "email": $email}]' \
		$CONFIG_FILE > $USER_CONFIG_FILE

	# Обновление оригинального конфигурационного файла
	mv $USER_CONFIG_FILE $CONFIG_FILE
	systemctl restart xray

	# Формирование ссылки для VLESS
	vless_link="vless://$user_uuid@$(hostname -I | awk '{print $1}'):443/?encryption=none&type=tcp&sni=example.com&security=reality&fp=chrome&pbk=$user_public_key"

	# Формирование ссылки для Shadowsocks
		ss_link="ss://2022-blake3-aes-128-gcm:$ss_password@$(hostname -I | awk '{print $1}'):54321"
	
		# Запись ссылок в файл
		echo "VLESS Link for $user_name: $vless_link" >> "$USER_LINKS_FILE"
		echo "Shadowsocks Link for $user_name: $ss_link" >> "$USER_LINKS_FILE"
	
		# Создание файлов пользователя
		create_user_files "$user_name" "$user_uuid" "$user_private_key" "$user_public_key"
	
		# Создание конфигурационного файла клиента
		create_client_config "$user_name" "$user_uuid" "$user_public_key" "$ss_password"
	}
	
	# Функция для удаления пользователя из конфигурации Xray
	remove_user() {
		local user_uuid="$1"
	
		echo "Удаление пользователя с UUID $user_uuid..."
	
		# Удаление пользователя из конфигурационного файла Xray
		jq --arg uuid "$user_uuid" '
			.inbounds[0].settings.clients |= map(select(.id != $uuid))
		' $CONFIG_FILE > $USER_CONFIG_FILE
	
		# Обновление оригинального конфигурационного файла
		mv $USER_CONFIG_FILE $CONFIG_FILE
		systemctl restart xray
	
		# Удаление файлов пользователя из папки
		local user_folder=$(find "$USER_DIR" -type d -name "*$user_uuid*" | head -n 1)
		if [ -n "$user_folder" ]; then
			rm -rf "$user_folder"
			echo "Файлы пользователя с UUID $user_uuid удалены из $USER_DIR."
		fi
	
		# Удаление конфигурационного файла клиента
		local client_config_file=$(find "$USER_DIR" -name "*${user_uuid}_config.json")
		if [ -n "$client_config_file" ]; then
			rm -f "$client_config_file"
			echo "Конфигурационный файл клиента с UUID $user_uuid удален из $USER_DIR."
		fi
	
		# Удаление ссылок пользователя из файла
		sed -i "/$user_uuid/d" "$USER_LINKS_FILE"
	}
	
	# Функция для отображения всех пользователей
	list_users() {
		echo "Список пользователей:"
		jq -r '.inbounds[0].settings.clients[] | "\(.email) - \(.id)"' $CONFIG_FILE
	}
	
	# Проверка наличия прав суперпользователя
	if [ "$EUID" -ne 0 ]; then
		echo "Пожалуйста, запустите этот скрипт с правами суперпользователя (sudo)."
		exit 1
	fi
	
	# Проверка наличия конфигурационного файла
	if [ ! -f "$CONFIG_FILE" ]; then
		echo "Файл конфигурации Xray не найден: $CONFIG_FILE"
		exit 1
	fi
	
	# Создание папки для пользователей, если не существует
	mkdir -p "$USER_DIR"
	
	# Меню для управления пользователями
	echo "Выберите действие:"
	echo "1. Просмотреть пользователей"
	echo "2. Добавить пользователя"
	echo "3. Удалить пользователя"
	read -p "Ваш выбор: " action
	
	case $action in
		1)
			list_users
			;;
		2)
			# Ввод данных для нового пользователя
			read -p "Введите имя пользователя: " user_name
			user_uuid=$(generate_uuid)
			keys=$(generate_x25519_keys)
			private_key=$(echo "$keys" | grep 'Private Key:' | awk '{print $NF}' | sed 's/ //g')
			public_key=$(echo "$keys" | grep 'Public Key:' | awk '{print $NF}' | sed 's/ //g')
			ss_password=$(generate_base64_key)  # Генерация пароля для Shadowsocks
	
			# Добавление нового пользователя
			add_user "$user_name" "$user_uuid" "$private_key" "$public_key" "$ss_password"
			echo "Пользователь $user_name успешно добавлен."
			;;
		3)
			# Ввод UUID пользователя для удаления
			read -p "Введите UUID пользователя для удаления: " user_uuid
	
			# Удаление пользователя
			remove_user "$user_uuid"
			echo "Пользователь с UUID $user_uuid успешно удален."
			;;
		*)
			echo "Некорректный выбор. Пожалуйста, выберите цифру от 1 до 3."
			exit 1
			;;
	esac
	
	echo "Ссылки для пользователей сохранены в файл: $USER_LINKS_FILE"