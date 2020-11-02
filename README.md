# Телеграм уведомления об ssh–авторизации на сервере

![](https://raw.githubusercontent.com/pdacity/ssh2tg/master/ssh2tg.gif)


Создание бота через BotFather — процесс очень простой. Да и, наверняка, бот у вас уже есть.

После создания бота необходимо запомнить его ID: bot12345678:ABCDefDHIjkLMnoPqrstuVW добавить его в канал

Узнаем ID канала/группы:
```
curl "https://api.telegram.org/bot12345678:ABCDefDHIjkLMnoPqrstuVW/sendMessage?chat_id=@My_Super_channel&text=test123"
```

Для избавления в оповещении строки типа '"readme": "https://ipinfo.io/missingauth"' можно зарегистрировать бесплатный аккаунт на  ipinfo.io, сгенерировать персональный токен и добавить его в переменную 'TOKEN'. 

В файл /etc/pam.d/sshd добавте строку:

```
session optional pam_exec.so type=open_session seteuid /usr/local/bin/ssh2tg.sh
```


