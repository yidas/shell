#!/bin/bash
  
# GCP Object Storage Backup Script - Specific Upload
#
# Copy specific local file to object storage with same name.   
# Equal to: gsutil cp file.zip gs://your-bucket
# Permission: Creator for once, Admin for overwrite
#
# @author  Nick Tsai <myintaer@gmail.com>
# @version 1.0.0
# @link    https://github.com/yidas/shell
#
# @example
#  ./gsutil-specific-upload.sh
#  ./gsutil-specific-upload.sh /var/www/html/project.zip
#  ./gsutil-specific-upload.sh /var/www/html/project.zip gs://your-bucket

# File full path
sourceFilePath="/var/www/html/project.zip"

# Directory for excuting and saving files
bucketPath="gs://your-bucket"

# Argument 1
if [ $1 ]
then
    sourceFilePath=$1
fi

# Argument 2
if [ $2 ]
then
    bucketPath=$2
fi

gsutil cp "${sourceFilePath}" "${bucketPath}"
