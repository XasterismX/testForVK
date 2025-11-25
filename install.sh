#!/bin/bash
# Скрипт установки
APP_DIR="/opt/app_monitor"
BIN_PATH="$APP_DIR/app"
MONITOR_SCRIPT="$APP_DIR/monitor.sh"

#Устанавливаем go для сервера
sudo apt update
sudo apt install golang-go

#Права на запуск мониторинга
chmod +x monitor.sh

# Создаем директорию
mkdir -p "$APP_DIR"

#Билдим файлы
go build -o app



# Копируем файлы (предполагается, что hello и monitor.sh лежат в текущей папке)
cp app "$BIN_PATH"
cp monitor.sh "$MONITOR_SCRIPT"

# Делаем исполняемым
chmod +x "$BIN_PATH" "$MONITOR_SCRIPT"

# Копируем unit-файлы systemd
cp app_monitor.service /etc/systemd/system/
cp app_monitor.timer /etc/systemd/system/

# Перезагружаем демон и включить таймер
systemctl daemon-reload
systemctl enable --now app_monitor.timer

echo "Установка завершена. Мониторинг запущен."
