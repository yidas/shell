#!/bin/bash

# Clean Up by days Script
#
# remove files fit by path and before days, which bases on file timestamp
#
# @author  Nick Tsai <myintaer@gmail.com>
# @version v1.0.0
#
# @param $1 Remove before day
# @param $2 Path
#
# @example
#  ./cleanup-by-days.sh 30
#  ./cleanup-by-days.sh 7 /var/log/*

# Directory for removing files
path="/root/backup/archives/*"

# Before day for remove
removeBeforeDay=0

# Argument 1
if [ $1 ]
then
    removeBeforeDay=$1
fi

# Argument 2
if [ $2 ]
then
    path=$2
fi


# Remove before backupfiles
if [[ $removeBeforeDay != 0 && $removeBeforeDay =~ ^[0-9]+$ ]]
then
    find $path -mtime +$removeBeforeDay -exec rm {} \;
    echo "rm ${path} at $(date +%Y-%m-%d)"
fi
