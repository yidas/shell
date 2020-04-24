#!/bin/bash
  
# GCP Object Storage Backup Script - Specific Upload
#
# Copy specific local file to object storage with same name.   
# Permission: Creator for once, Admin for overwrite
#
# @author  Nick Tsai <myintaer@gmail.com>
# @version 1.0.0
# @link    https://github.com/yidas/shell
#
# @example
#  ./gsutil-specific-upload.sh
#  ./gsutil-specific-upload.sh /var/www/html/project.zip

# File full path
sourceFilePath="/var/www/html/project.zip"

# Directory for excuting and saving files
backupPath="gs://bucket"

# Argument 1
if [ $1 ]
then
    sourceFilePath=$1
fi

gsutil cp "${sourceFilePath}" "${backupPath}"
