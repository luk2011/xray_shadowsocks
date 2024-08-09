#!/bin/bash

# Определение домашних папок и путей
USER_HOME=$(eval echo ~$SUDO_USER)
CONFIG_FILE="/usr/local/etc/xray/config.json"
USER_CONFIG_FILE="$USER_HOME/xray_config.json"
USER_DATA_FILE="$USER_HOME/xray_user_data.txt"
CLIENT_LINKS_FILE="$USER_HOME/xray_client_links.txt"
USER_DIR="$USER_HOME/xray_users"
USER_LINKS_FILE="$USER_HOME/xray_user_links.txt"

# Функция для установки Xray
install_xray() {
    echo "Установка Xray..."
    
    # Удаление старых версий Xray
    if command -v xray >/dev/null 2>&1; then
        echo "Xray уже установлен. Удаляем старую версию..."
        apt-get remove --purge xray -y
    fi

    # Загрузка и установка Xray
    wget -qO /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/xray-linux-amd64.zip
    unzip /tmp/xray.zip -d /usr/local/bin/
    chmod +x /usr/local/bin/xray
    rm /tmp/xray.zip

    # Создание необходимой директории
    mkdir -p /usr/local/etc/xray

    # Установка необходимых зависимостей
    apt-get update
    apt-get install -y jq unzip curl libsodium-dev
    echo "Xray успешно установлен."
}

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

# Вывод для проверки
echo "Private Key: $private_key"
echo "Public Key: $public_key"
echo "UUID: $user_uuid"
echo "Shadowsocks Password: $ss_password"

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
    
    # Инициализация переменных для хранения данных пользователей
    users_config=""
    
    # Очистка файла ссылок для пользователей
    : > "$USER_LINKS_FILE"
    
    while true; do
        # Ввод имени пользователя
        read -p "Введите имя пользователя (или оставьте пустым для завершения): " user_name
        
        if [[ -z "$user_name" ]]; then
            break
        fi
        
        # Генерация UUID для пользователя
        user_id=$(generate_uuid)
        
        # Добавление данных пользователя в конфигурацию
        users_config+=$(cat <<EOF
        {
          "id": "$user_id",
          "email": "$user_name"
        },
EOF
        )
        
        # Создание файла с данными пользователя
        user_file="$USER_DIR/${user_name}_data.txt"
        cat > "$user_file" <<EOF
UUID: $user_id
Private Key: $private_key
Public Key: $public_key
EOF

        echo "Данные для пользователя $user_name сохранены в $user_file"
        
        # Формирование ссылки для VLESS
        user_vless_link="vless://$user_id@$server_ip:443/?encryption=none&type=tcp&sni=$camouflage_domain&fp=chrome&security=reality&alpn=h2&flow=xtls-rprx-vision&pbk=$public_key&packetEncoding=xudp"
        # Формирование ссылки для Shadowsocks
        user_ss_link="ss://2022-blake3-aes-128-gcm:$ss_password@$server_ip:$ss_port"
        
        # Запись ссылок в файл
        echo "VLESS Link for $user_name: $user_vless_link" >> "$USER_LINKS_FILE"
        echo "Shadowsocks Link for $user_name: $user_ss_link" >> "$USER_LINKS_FILE"
    done

    # Удаление последней запятой и добавление закрывающей скобки
    users_config=$(echo "$users_config" | sed '$ s/,$//')
fi

# Создание конфигурационного файла
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
echo "Приватный ключ Reality: $private_key"
echo "UUID пользователя: $user_uuid"
echo "Порт для Shadowsocks: $ss_port"
echo "Порт для SSH: ${ssh_port:-22}"
echo "Сохраненные конфигурационные файлы и ссылки:"
echo "Конфигурационный файл: $USER_CONFIG_FILE"
echo "Файл с данными пользователя: $USER_DATA_FILE"
echo "Файл с ссылками для клиента: $CLIENT_LINKS_FILE"
echo "Файл с ссылками пользователей: $USER_LINKS_FILE"
