#!/bin/sh

FILE_NAME="path_of_file"

HOST='IP Addr. of ftp server'

USER='user_name'

PASSWD='user_passwd'

ftp -nv <<EOF
open $HOST
user $USER $PASSWD
cd db_backups/PUNE/
put $FILE_NAME

EOF
