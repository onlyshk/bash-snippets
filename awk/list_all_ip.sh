#!/bin/bash
d=$1
OUT=/tmp/spam.ip.$$
HTTPDLOG="/www/$d/var/log/httpd/access.log"
[ $# -eq 0 ] && { echo "Usage: $0 domain-name"; exit 999; }
if [ -f $HTTPDLOG ];
then
	awk '{print}' $HTTPDLOG >$OUT
	awk '{ print $1}' $OUT  |  sort -n | uniq -c | sort -n
else
	echo "$HTTPDLOG not found. Make sure domain exists and setup correctly."
fi
/bin/rm -f $OUT
