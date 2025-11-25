#!/bin/bash
# Проверяет доступность веб-сервера по HTTP, логирует результат и перезапускает при сбое
APP_PORT=8080
APP_PATH="./app" #путь к бинарному файлу
LOG="/var/log/test_server_monitoring" # Путь к логу
URL="http://localhost:$APP_PORT" #путь к ресурсу

#Функция логирования
log(){
  echo "$(date +'%Y-%m-%d %H:%M:%S') $1" >> "$LOG"
}
#Функция проверки урла
check_url(){
 curl -s --max-time 5 "$URL" > /dev/null
 return $?
}

#Перезапуск приложения
restart_app(){
  log "Попытка перезапуска"
  pkill -f "$APP_PATH"
  "$APP_PATH" & disown
  log "Перезапуск успешен"
}

#Главная функция

main(){
  if ! check_url; then
    log "URL недоступен"
    restart_app
  else
    log "URL доступен"
  fi
}

main