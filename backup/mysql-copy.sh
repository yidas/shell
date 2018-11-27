#!/bin/bash

# Database Copy Script
#
# Provides two servers's database copy
#
# @author  Nick Tsai <myintaer@gmail.com>
# @version 1.0.0
# @link    https://github.com/yidas/shell

#
# Configuration
#

# Source Database Config
declare -A src
src[dbName]="source_dbname"
src[dbUser]=""
src[dbPasswd]=""
src[charset]="utf8"
src[dbHost]="source.db.com"

# Destination Database Config
declare -A dst
dst[dbName]=""
dst[dbUser]=""
dst[dbPasswd]=""
dst[charset]="utf8"
dst[dbHost]="localhost"

# Directory for temporary saving files
tmpPath="/tmp"

# Date format for filename
dateFormat='%Y%m%d'

# Database Advanced Config
# Table Array to Use --no-data (Ex. Log table)
# #example nodataTables=("log" "sys_log")
nodataTables=()

#
# /Configuration
#

now=$(date +$dateFormat)
cd "$tmpPath"

# Auto DB name
if [ "${dst[dbName]}" == '' ]
then
    dst[dbName]="${src[dbName]}_${now}";
    count=0;
    while : ; do
        result=$(echo "show databases;" | mysql -h${dst[dbHost]} -u ${dst[dbUser]} -p${dst[dbPasswd]} | grep "${dst[dbName]}" | wc -l);
        if [ $result != "0" ]
        then
            count=$(($count+1));
            dst[dbName]="${src[dbName]}_${now}_${count}";
        else
            break;
        fi
    done
fi

# Auto Distant Setting 
for i in "${!dst[@]}"
do
    # Same as source if not set
    if [ "${dst[$i]}" == '' ]
    then
        dst[$i]="${src[$i]}"
    fi
done

# Option for nodataTables setting
ignoreTableString="";
if [[ ${nodataTables[@]} ]]
then
    for i in "${nodataTables[@]}"
    do
       ignoreTableString="${ignoreTableString} --ignore-table=${src[dbName]}.${i}"
    done
fi


# Copy Process
sqlFile="${src[dbName]}.sql"

# Create database query
query='create database `'${dst[dbName]}'` DEFAULT CHARACTER SET '${dst[charset]}'; use `'${dst[dbName]}'`;'
mysql -h${dst[dbHost]} -u ${dst[dbUser]} -p${dst[dbPasswd]} -e "${query}"

# Dump structure
mysqldump -h${src[dbHost]} -u ${src[dbUser]} -p${src[dbPasswd]} --set-gtid-purged=off --default-character-set=${src[charset]} --no-data ${src[dbName]} > "${sqlFile}";
mysql -h${dst[dbHost]} -u ${dst[dbUser]} -p${dst[dbPasswd]} ${dst[dbName]} < "${sqlFile}";

# Dump data
mysqldump -h${src[dbHost]} -u ${src[dbUser]} -p${src[dbPasswd]} --set-gtid-purged=off --default-character-set=${src[charset]} ${src[dbName]} ${ignoreTableString}  > "${sqlFile}";
mysql -h${dst[dbHost]} -u ${dst[dbUser]} -p${dst[dbPasswd]} ${dst[dbName]} < "${sqlFile}";

# Remove files after copy
rm -f "${sqlFile}"

exit 1
