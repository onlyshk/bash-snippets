#!/bin/bash

read -p "Enter disk space must be usage: " disk;

usage=`df -h | awk '{print $5}' | sed -e N -e 's/\n/ /' | awk '{print $2}' | tr -d % -s "\n"`
devnm=`df -h | awk '{print $1}' | sed -e N -e 's/\n/ /' | awk '{print $2}' | tr -s "\n"`
str="============================="

if [ $usage -ge $disk ]; then
info="Disk usage for $devnm is more than $disk , Current Disk usage is $usage % "
echo -e "$str\n$info\n$str" |mail -s "Alert: Disk Usage for `hostname` on `date`" admin@example.com

else
info="Disk Usage is $usage% for $devnm"
# echo -e "$str\n$info\n$str" | mail -s "Alert: Disk Usage for `hostname` on `date`" admin@example.com
fi
