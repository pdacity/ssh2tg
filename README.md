# Телеграм–уведомления об ssh–авторизации на сервере через своего tg–бота

![](https://raw.githubusercontent.com/pdacity/ssh2tg/master/ssh2tg.gif)


Создание бота через BotFather — процесс очень простой. Да и, наверняка, бот у вас уже есть.

В двух словах: Создали бота. Записали на бумажку ключ бота: bot12345678:ABCDefDHIjkLMnoPqrstuVW Создали канал/группу. Обозвали его/её как–нить публично, типа My_Super_channel. Добавили бота в канал.

Узнаем ID канала/группы:
```
curl "https://api.telegram.org/bot12345678:ABCDefDHIjkLMnoPqrstuVW/sendMessage?chat_id=@My_Super_channel&text=test123"
```

Ищем в ответе значение chat":{"id":–9876543210...
(в этот момент, кстати, должно упасть сообщение test123 в вашу телегу. Если упало, значит всё окей). Если надо, делаем канал/группу приватными.

Для избавления в оповещении строки типа '"readme": "https://ipinfo.io/missingauth"' можно зарегистрировать бесплатный аккаунт на  ipinfo.io, сгенерировать персональный токен и добавить его в переменную 'TOKEN'. 


Создаем файл `/usr/local/bin/ssh2tg.sh`

```
#!/bin/bash
TOKEN=8888888888
KEY="12345678:ABCDefDHIjkLMnoPqrstuVW"
URL="https://api.telegram.org/bot$KEY/sendMessage"
TARGET="айди_контакта/группы/канала_куда_отправлять_уведомления" #в нашем случае это –9876543210, именно с минусом.
DATE1="$(date "+%H:%M:%S")"
DATE2="$(date "+%d %B %Y")"
GEO="$(curl ipinfo.io/?token=$TOKEN&$PAM_RHOST)"
TEXT="*$PAM_USER* залогинился на *$HOSTNAME*
Время: $DATE1
Дата: $DATE2
Адрес: $PAM_RHOST
Service: $PAM_SERVICE
TTY: $PAM_TTY
GEO: ${GEO}"
PAYLOAD="chat_id=$TARGET&text=$TEXT&parse_mode=Markdown&disable_web_page_preview=true"
curl –s ––max–time 10 ––retry 5 ––retry–delay 2 ––retry–max–time 10 –d "$PAYLOAD" $URL > /dev/null 2>&1 &
```

Теперь, в файл /etc/pam.d/sshd добавляем строчку:

```
session optional pam_exec.so type=open_session seteuid /usr/local/bin/ssh2tg.sh
```


