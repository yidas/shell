Login Alert
===========

1. Create the bash for sending mail by root

2. Add command into `/etc/pam.d/sshd`

```
session optional pam_exec.so seteuid /path/to/login-notify.sh
```



References
---

[Ask Ubuntu - How do I set up an email alert when a ssh login is successful?](https://askubuntu.com/questions/179889/how-do-i-set-up-an-email-alert-when-a-ssh-login-is-successful)
