#!/bin/bash
  
# SFTP Backup Script - Specific Upload
#
# Copy specific local file to SFTP server with same name.   
# Permission: The SFTP user requires the authorized_key in remote
#
# @author  Nick Tsai <myintaer@gmail.com>
# @version 1.0.0
# @link    https://github.com/yidas/shell
#
# @example
#  ./sftp-cp.sh
#  ./sftp-cp.sh /var/www/html/project.zip
#  ./sftp-cp.sh /var/www/html/project.zip

# SFTP command
sftpCmd="sftp_user@sftphostname:/remote-path"

# SFTP port
sftpPort=22

# File full path
sourceFilePath="/var/www/html/project.zip"

# Argument 1
if [ $1 ]
then
    sourceFilePath=$1
fi

sftp -P "${sftpPort}" "${sftpCmd}" <<EOF
put "${sourceFilePath}"
exit
EOF
