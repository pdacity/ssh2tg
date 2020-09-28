#!/usr/bin/env bash

# Generate new tocken by register free plan on ipinfo.io
TOKEN=

KEY="111111111:AAELEbbbbbbbbbbbbbbbbbbbbbbbbbbblno"
URL="https://api.telegram.org/bot$KEY/sendMessage"
TARGET="222222222" #в нашем случае это -9876543210, именно с минусом.
DATE1="$(date "+%H:%M:%S")"
DATE2="$(date "+%d %B %Y")"
GEO="$(curl ipinfo.io/?token=$TOKEN&$PAM_RHOST)"

TEXT="🔥 *$PAM_USER* залогинился на *$HOSTNAME* 
Время: $DATE1
Дата: $DATE2
Адрес: $PAM_RHOST
Service: $PAM_SERVICE
TTY: $PAM_TTY
GEO: ${GEO}"
PAYLOAD="chat_id=$TARGET&text=$TEXT&parse_mode=Markdown&disable_web_page_preview=true"
curl -s --max-time 10 --retry 5 --retry-delay 2 --retry-max-time 10 -d "$PAYLOAD" $URL > /dev/null 2>&1 &
