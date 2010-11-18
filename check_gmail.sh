#!/bin/bash

read -p "Input your name in gmail: " username;
read -p "Input your password in gmail: " password;

echo -e "Checking for new messages... \c"
 
atomlines=`wget -T 3 -t 1 -q --secure-protocol=TLSv1 \
 --no-check-certificate \
 --user=$username --password= $password \
 https://mail.google.com/mail/feed/atom -O - \
 | wc -l`
 
echo -e "\r\c"
 
[ $atomlines -gt "8" ] \
 && echo -e " You have new gmail." \
 || echo -e " No new gmail."
