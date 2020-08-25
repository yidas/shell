#!/bin/bash
  
# LFTP Backup Script - Upload/Download
#
# Put or get specific file between local and SFTP server with same name.  
#
# @author  Nick Tsai <myintaer@gmail.com>
# @version 1.0.0
# @link    https://github.com/yidas/shell
#
# @example
#  ./lftp-get-put.sh

# LFTP config
host="ftps://yourftps.local"
username=""
password=""
optionString="set ssl:verify-certificate false;"
# File config
dateFormat=$(date +"%Y%m%d")
filename="FILE_${dateFormat}.ZIP"
# put: Upload | mget: Download
method="mget"

# LFTP command process
lftp -e "
${optionString}
open ${host}; 
login ${username} ${password}; 
${method} ${filename}; 
bye;"
