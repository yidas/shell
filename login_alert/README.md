Login Alert
===========

1. Create the bash ([login-notify.sh](https://github.com/yidas/shell/blob/master/login_alert/login-notify.sh)) for sending mail executed by root (`chmod +x`)

2. Add command into `/etc/pam.d/sshd`

```
session optional pam_exec.so seteuid /path/to/login-notify.sh
```



References
---

[Ask Ubuntu - How do I set up an email alert when a ssh login is successful?](https://askubuntu.com/questions/179889/how-do-i-set-up-an-email-alert-when-a-ssh-login-is-successful)
