#!/bin/bash

# Worker Process Keeper
#
# Keep the command process alive uniquely by adding to crontab, this will auto 
# recall service if the service is not in the process list. 
#
# @author  Nick Tsai <myintaer@gmail.com>
# @version 1.0.0
# @link    https://github.com/yidas/shell
# @example
#  ./worker_keeper.sh "php /var/www/html/worker.php" "> /root/worker.log"

# Service command showed in process list
SERVICE_CMD="php /var/www/html/worker.php"

# Add-on command which is not showed in process list
ADDON_CMD="> /root/worker.log"

if [ "$1" ]; then
    SERVICE_CMD=$1
fi

if [ "$2" ]; then
    ADDON_CMD=$2
fi

# First character handle for [c]ommand expression (supported "grep" in CMD)
FIRST_CHAR=${SERVICE_CMD:0:1}
FIRST_CHAR="[${FIRST_CHAR}]"
# Grep string with [c]ommand expression
SERVICE_GREP=$(echo $SERVICE_CMD | sed s/./$FIRST_CHAR/1)

# grep invert for filtering ps self running command
RUNNING_PROCESS="$(ps aux | grep "$SERVICE_GREP" | grep -v "$0")"

if [ -z "$RUNNING_PROCESS" ]; then
    echo "Service is inactived, active now:"
    eval "${SERVICE_CMD} ${ADDON_CMD} &"
else
    echo "Service is actived"
    echo $RUNNING_PROCESS
fi
