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
src[dbName]="db_name"
src[dbUser]=""
src[dbPasswd]=""
src[charset]="utf8"
src[dbHost]="localhost"

# Destination Database Config
declare -A dst
dst[dbName]="" # Empty to use auto database name generator
dst[dbUser]=""
dst[dbPasswd]=""
dst[charset]="utf8"
dst[dbHost]="localhost"

# Directory for temporary saving files
tmpPath="/tmp"

# Date format for filename
dateFormat='%Y%m%d'

#
# /Configuration
#


now=$(date +$dateFormat)
cd "$tmpPath"


# Auto DB name
if [ "${dst[dbName]}" == '' ]
then
    dst[dbName]="${src[dbName]}_${now}"
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

# Main Database Handler
sqlFile="${src[dbName]}.sql"
mysqldump -h${src[dbHost]} -u ${src[dbUser]} -p${src[dbPasswd]} --default-character-set=${src[charset]} ${src[dbName]} > "${sqlFile}"

# Create database query
query='create database `'${dst[dbName]}'` DEFAULT CHARACTER SET '${src[charset]}'; use `'${dst[dbName]}'`;'

mysql -h${dst[dbHost]} -u ${dst[dbUser]} -p${dst[dbPasswd]} -e "${query}"
mysql -h${dst[dbHost]} -u ${dst[dbUser]} -p${dst[dbPasswd]} ${dst[dbName]} < "${sqlFile}"

# Remove files after copy
rm -f "$sqlFile"

exit 1
