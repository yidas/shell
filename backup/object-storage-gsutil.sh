#!/bin/bash

# Object Storage Backup Script
#
# Copy local file to object storage.   
#
# @author  Nick Tsai <myintaer@gmail.com>
# @version 0.1.0
# @link    https://github.com/yidas/shell
#
# @example
#  ./object-storage-gsutil.sh
#  ./object-storage-gsutil.sh /var/www/html project.zip

# Directory of source code for tar except path
sourcePath="/var/www/html/"

# File for tar output, use `.` for all
sourceFile="file.zip"

# Directory for excuting and saving files
backupPath="gs://bucket"

# Date format for filename
dateFormat='%Y%m%d'

# Backup filename
backupFilename="backup"

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

    gsutil cp "${sourceFile}" "${backupPath}/${backupFilename}_${now}_${sourceFile}"

# Remove before backupfile
if [ $removeBeforeDay != 0 ]
then
    gsutil rm "${backupPath}/${backupFilename}_${before}_${sourceFile}"
fi
