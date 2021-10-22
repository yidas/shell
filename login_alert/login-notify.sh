#!/bin/sh

# Change these two lines:
sender="System Notification <system@yourdomain.local>"
recepient="to@todomain.local"

if [ "$PAM_TYPE" != "close_session" ]; then
    host="`hostname`"
    subject="Notification of SSH Login: $PAM_USER from $PAM_RHOST on $host"
    # Message to send, e.g. the current environment variables.
    message="`env`"
    echo "$message" | mailx -a "From:$sender" -s "$subject" "$recepient"
fi
