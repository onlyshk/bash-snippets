#!/bin/bash

declare -i count
ver=0.4
choise=endless
browser=none

#
# RDF/RSS reader 
#
#	Pretty lame actualy..
#	Could have used some functions instead of c-and-p
#	Might make it to smallest rdf/rss reader 
#	For updates check http://etv.cx/~the_jinx/rssread
#
#	Anne Jan Brouwer (the_JinX)
#	 last edited 2004-05-15

echo "rss reader $ver"
echo 

# usage
if [[ -z $1 || $1 == "--help" ]]; then
echo "usage: $0 url (browser)"
echo "will use elinks, links, lynx or a fallback;"
echo "if no browser set.."
exit
fi

# make tempfile
if [[ -e `which tempfile` ]]; then
tempfile=$(tempfile -p rss)
else
tempfile="/tmp/rssread"
touch $tempfile
fi

# download
wget $1 -O $tempfile
if [[ $? != 0 ]]; then
echo "wget error or wget not installed"
rm $tempfile
exit
fi

# shave titles
cat $tempfile | grep "&lt;title&gt;" | cut -d "&gt;" -f 2 | cut -d "&lt;" -f 1 &gt; $tempfile"title"
# shave url
cat $tempfile | grep "&lt;link&gt;" | cut -d "&gt;" -f 2 | cut -d "&lt;" -f 1 &gt; $tempfile"link"

# count links and titles
titles=$( wc -l $tempfile"title" | cut -d " " -f 1 )
links=$( wc -l $tempfile"link" | cut -d " " -f 1 )
if [[ $titles == 0 || $urls == 0 ]]; then
echo "no good.."
rm $tempfile*
exit
fi

# check if titles match urls
if [[ $titles -gt $links ]]; then
echo "more titles then links"
fi
if [[ $titles -lt $links ]]; then
echo "less titles then links"
fi

# The MAIN Loop

while [[ $choice != "" || $choice != 0 ]]; do
clear
# show title
echo "rss reader $ver"
echo "reading $1"
echo

# list items
count=1
while [[ $count -lt $titles ]]; do
# print titles
line=$( cat $tempfile"title" | head -n $count | tail -n 1 )
printf "%s\t" $count
echo $line
count=$count+1
done

# ask
echo
echo "Which would you like to read ?"
echo "0, q and x quit."
read choice
choice=$( echo $choice | tr A-Z a-z )
until [[ $choice != "" && $choice -gt 0 && $choice -le $titles ]]; do
if [[ $choice == 0 || $choice == "q" || $choice == "x" ]]; then
echo "bye.." 
rm $tempfile*
exit
else
echo "BURP" 
fi
read choice
choice=$( echo $choice | tr A-Z a-z )
done

# get link
link=$( cat $tempfile"link" | head -n $choice | tail -n 1)
link=${link//&amp;/&}
#link=${link//&/%26}

# browser 
if [[ -e $( which lynx 2&gt; /dev/null ) ]]
then 
browser=lynx
fi
if [[ -e $( which links 2&gt; /dev/null ) ]]
then 
browser=links
fi
if [[ -e $( which elinks 2&gt; /dev/null ) ]]
then 
browser=elinks
fi
if [[ $2 != "" ]]; then
if [[ -e $( which $2 2&gt; /dev/null ) ]]
then 
browser=$2
else
echo "$2 does not seem to be a browser :("
fi
fi

# showtime
if [[ $browser == none ]]; then
if [[ -e $( which sed ) ]]; then
wget -q -O - $link | sed -e 's/&lt;.*&gt;//' | sed -e '/^$/d' | less
else
wget -q -O - $link | less
fi
else 
$browser "$link"
if [[ $? != 0 ]]; then
echo "browser error"
read -s -n1
fi
fi
done

#remove tempfiles
rm $tempfile*

#EOF

