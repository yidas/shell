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

# Date format for filename
dateFormat='%Y%m%d'
now=$(date +$dateFormat)

# Directory of source code for tar except path
sourcePath="/var/www/html/"

# File for tar output, use `.` for all
sourceFile="file_${now}.zip"

# Directory for excuting and saving files
backupPath="gs://bucket"

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


before=$(date -d "-${removeBeforeDay} days" +$dateFormat)
cd "$sourcePath"

    gsutil cp "${sourceFile}" "${backupPath}"

# Remove before backupfile
if [ $removeBeforeDay != 0 ]
then
    gsutil rm "${backupPath}/${backupFilename}_${before}_${sourceFile}"
fi
