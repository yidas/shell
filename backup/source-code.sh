#!/bin/bash

# Source Code Backup Script
#
# Compress source code by path and file.   
#
# @author  Nick Tsai <myintaer@gmail.com>
# @version 1.0.1
# @link    https://github.com/yidas/shell
#
# @example
#  ./source-code.sh
#  ./source-code.sh /var/www/html project

# Directory of source code for tar except path
sourcePath="/var/www/html/"

# File for tar output, use `.` for all
sourceFile="project"

# Directory for excuting and saving files
backupPath="/root/backup/archives"

# Date format for filename
dateFormat='%Y%m%d'

# Backup filename
backupFilename="backup-code"

# Before day for remove, for daily crontab usage
removeBeforeDay=0

# Argument 1
if [ $1 ]
then
    sourcePath=$1
fi

# Argument 2
if [ $2 ]
then
    sourceFile=$2
fi

now=$(date +$dateFormat)
before=$(date -d "-${removeBeforeDay} days" +$dateFormat)
cd "$backupPath"

# Compress source file by path
tar zcf "${backupFilename}_${now}.tar.gz" -C $sourcePath $sourceFile

# Remove before backupfile
if [ $removeBeforeDay != 0 ]
then
    rm -f "${backupFilename}_${before}.tar.gz"
fi
