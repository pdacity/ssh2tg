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

Теперь, в файл /etc/pam.d/sshd добавляем строчку:

```
session optional pam_exec.so type=open_session seteuid /usr/local/bin/ssh2tg.sh
```


