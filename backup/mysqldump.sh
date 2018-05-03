#!/bin/bash

# Database Backup Script
#
# Provides multiple mysqldump commands with compressing into one.
#
# @author  Nick Tsai <myintaer@gmail.com>
# @version 1.1.0
# @link    https://github.com/yidas/shell
# @example
#  # /etc/cron.d
#  00 02 * * 0 [ $(date +\%d) -le 07 ] && root /root/backup/mysqldump.sh > /dev/null

#
# Configuration
#

# Database Config
dbName=""
dbUser="root"
dbPasswd=""
charset="utf8"
dbHost="localhost"

# Database Advanced Config
# Table Array to Use --skip-extended-insert (Ex. Big-Text table)
# #example insertTables=("stroage" "json_text")
insertTables=("")
# Table Array to Use --no-data (Ex. Log table)
# #example nodataTables=("log" "sys_log")
nodataTables=("")

# Directory for excuting and saving files
backupPath="/root/backup/archives"

# Date format for filename
dateFormat='%Y%m%d'

# Backup filename
backupFilename="backup-sql"

# Before day for remove, for daily crontab usage
removeBeforeDay=0

#
# /Configuration
#


now=$(date +$dateFormat)
before=$(date -d "-${removeBeforeDay} days" +$dateFormat)
sqlList=()
cd "$backupPath"

# Ignore Tables = insertTables + nodataTables
ignoreTableString=""

# Option for insertTables setting
if [[ ${insertTables[@]} ]]
then
    tableString=""
    for i in "${insertTables[@]}"
    do
       tableString="${tableString} ${i}"
       ignoreTableString="${ignoreTableString} --ignore-table=${dbName}.${i}"
    done

    # Command
    sqlFile="${dbName}_insert.sql"
    mysqldump -h$dbHost -u $dbUser -p$dbPasswd --skip-extended-insert --default-character-set=$charset $dbName $tableString  > "${sqlFile}"
    sqlList+=("${sqlFile}")
fi

# Option for nodataTables setting
if [[ ${nodataTables[@]} ]]
then
    tableString=""
    for i in "${nodataTables[@]}"
    do
       tableString="${tableString} ${i}"
       ignoreTableString="${ignoreTableString} --ignore-table=${dbName}.${i}"
    done

    # Command
    sqlFile="${dbName}_nodata.sql"
    mysqldump -h$dbHost -u $dbUser -p$dbPasswd --no-data --default-character-set=$charset $dbName $tableString  > "${sqlFile}"
    sqlList+=("${sqlFile}")
fi

# Main Database Handler
sqlFile="${dbName}.sql"
mysqldump -h$dbHost -u $dbUser -p$dbPasswd --default-character-set=$charset $dbName $ignoreTableString > "${sqlFile}"
sqlList+=("${sqlFile}")

# Main Database All Tables Structure Only Handler
sqlFile="${dbName}_structure_all.sql"
mysqldump -h$dbHost -u $dbUser -p$dbPasswd --no-data --default-character-set=$charset $dbName > "${sqlFile}"
sqlList+=("${sqlFile}")


# Compress all files in sqlList
tar zcvf "${backupFilename}_${now}.tar.gz" "${sqlList[@]}"

# Remove files after compress
rm -f "${sqlList[@]}"

# Remove before backupfile
if [ $removeBeforeDay != 0 ]
then
    rm -f "${backupFilename}_${before}.tar.gz"
fi

exit 1

