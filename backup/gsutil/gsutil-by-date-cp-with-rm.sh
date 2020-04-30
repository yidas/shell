#!/bin/bash
  
# GCP Object Storage Backup Script
#
# Copy local file to object storage by dynamic date with remove old one.
# Permission: Creator for once, Admin for overwrite
#
# @author  Nick Tsai <myintaer@gmail.com>
# @version 0.1.0
# @link    https://github.com/yidas/shell
#
# @example
#  ./object-storage-gsutil.sh
#  ./object-storage-gsutil.sh /var/www/html project.zip

# Before day for remove, for daily crontab usage
removeBeforeDay=0

# Date format for filename
dateFormat='%Y%m%d'
now=$(date +$dateFormat)
before=$(date -d "-${removeBeforeDay} days" +$dateFormat)

# Directory of source code for tar except path
sourcePath="/var/www/html/"

# File for tar output, use `.` for all
sourceFile="file_${now}.zip"
deteleFile="file_${before}.zip"

# Directory for excuting and saving files
backupPath="gs://bucket"

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

cd "$sourcePath"

    gsutil cp "${sourceFile}" "${backupPath}"

# Remove before backupfile
if [ $removeBeforeDay != 0 ]
then
    gsutil rm "${backupPath}/${deteleFile}"
fi
