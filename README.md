Xray Installation and User Management Scripts

Этот пакет содержит два скрипта:

	1.	install_xray.sh: Устанавливает и настраивает Xray с поддержкой VLESS и Shadowsocks, включая настройку прокси-сервера и TLS.
	2.	manage_xray_users.sh: Управляет пользователями Xray, включая добавление, удаление и просмотр пользователей.

Содержание

	1.	Описание скриптов
	2.	Установка
	3.	Использование
	4.	Примеры
	5.	Общие замечания

Описание скриптов

install_xray.sh

Этот скрипт позволяет:

	•	Установить Xray на Ubuntu Server 22.04.
	•	Настроить VLESS с поддержкой Reality.
	•	Настроить Shadowsocks с поддержкой мультиплексирования.
	•	Обновить настройки системного сетевого стека для улучшения производительности.
	•	Настроить SSH сервер.

manage_xray_users.sh

Этот скрипт позволяет:

	•	Просматривать текущих пользователей.
	•	Добавлять новых пользователей с генерацией UUID и ключей.
	•	Удалять пользователей.
	•	Создавать файлы с данными пользователя в корневой папке.
	•	Генерировать ссылки для подключения по VLESS и Shadowsocks.

Установка

Установка Xray

	1.	Скачайте архив:
curl -L https://codeload.github.com/luk2011/xray_shadowsocks/tar.gz/main | tar -xz
	2.	Сделайте скрипт исполняемым:
chmod +x install_xray.sh
	3.	Запустите скрипт с правами суперпользователя:
sudo ./install_xray.sh

Управление пользователями Xray

	1.	Скачайте скрипт управления пользователями:
wget https://example.com/manage_xray_users.sh
	2.	Сделайте скрипт исполняемым:
chmod +x manage_xray_users.sh
	3.	Запустите скрипт с правами суперпользователя:
sudo ./manage_xray_users.sh

Использование

install_xray.sh

	1.	Запустите скрипт с правами суперпользователя:
sudo ./install_xray.sh
	2.	Следуйте инструкциям на экране для установки и настройки Xray.

manage_xray_users.sh

	1.	Запустите скрипт с правами суперпользователя:
sudo ./manage_xray_users.sh
2.	Выберите действие из меню:
	•	1: Просмотреть пользователей
	•	2: Добавить пользователя
	•	3: Удалить пользователя
	3.	Следуйте инструкциям на экране для выполнения выбранного действия.

Общие замечания

	•	Убедитесь, что у вас установлены jq, openssl и другие необходимые утилиты.
	•	Скрипты должны запускаться с правами суперпользователя для доступа к системным файлам и службам.
	•	При переносе скриптов на другой компьютер убедитесь, что права доступа сохраняются, и файлы исполняемы.
	•	В случае переноса конфигураций и файлов убедитесь, что все пути и ссылки актуальны для нового окружения.

