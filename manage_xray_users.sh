#!/bin/bash

# Определение домашней папки текущего пользователя
USER_HOME=$(eval echo ~$SUDO_USER)
# Путь к конфигурационному файлу Xray
CONFIG_FILE="/usr/local/etc/xray/config.json"
# Путь к конфигурационному файлу Xray в домашней папке пользователя
USER_CONFIG_FILE="$USER_HOME/xray_config.json"
# Путь для создания папки пользователей в корневой папке текущего пользователя
USER_DIR="$USER_HOME/xray_users"
# Путь для хранения ссылок пользователей
USER_LINKS_FILE="$USER_HOME/xray_user_links.txt"

# Функция для генерации нового UUID
generate_uuid() {
    uuidgen
}

# Функция для генерации публичного ключа из приватного
generate_public_key() {
    echo "$1" | openssl pkey -pubout -outform DER | openssl base64
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

# Функция для добавления нового пользователя в конфигурацию Xray
add_user() {
    local user_name="$1"
    local user_uuid="$2"
    local user_private_key="$3"
    local user_public_key="$4"

    echo "Добавление пользователя $user_name с UUID $user_uuid..."

    # Добавление нового пользователя в конфигурационный файл Xray
    jq --arg uuid "$user_uuid" --arg email "$user_name" \
        '.inbounds[0].settings.clients += [{"id": $uuid, "email": $email}]' \
        $CONFIG_FILE > $USER_CONFIG_FILE

    # Обновление оригинального конфигурационного файла
    mv $USER_CONFIG_FILE $CONFIG_FILE
    systemctl restart xray

    # Формирование ссылки для VLESS
    vless_link="vless://$user_uuid@$(hostname -I | awk '{print $1}'):443/?encryption=none&type=http&sni=example.com&host=somefakedummytext.com&path=%2F0J3QsNCy0LDQu9GM0L3Ri9C5&fp=chrome&security=reality&alpn=h2&pbk=$user_public_key&packetEncoding=xudp"

    # Формирование ссылки для Shadowsocks
    ss_link="ss://2022-blake3-aes-128-gcm:$ss_password@$(hostname -I | awk '{print $1}'):54321"

    # Запись ссылок в файл
    echo "VLESS Link for $user_name: $vless_link" >> "$USER_LINKS_FILE"
    echo "Shadowsocks Link for $user_name: $ss_link" >> "$USER_LINKS_FILE"

    # Создание файлов пользователя
    create_user_files "$user_name" "$user_uuid" "$user_private_key" "$user_public_key"
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
        private_key=$(openssl genpkey -algorithm X25519)
        public_key=$(generate_public_key "$private_key")
        ss_password=$(openssl rand -base64 16)  # Генерация пароля для Shadowsocks

        # Добавление нового пользователя
        add_user "$user_name" "$user_uuid" "$private_key" "$public_key"
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
