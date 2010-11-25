#!/bin/sh
PIDS=`ps ax | grep 'updatedb\|find' | grep -v grep | sort | awk
  '{print $1}' | perl -ne 'chomp;print "$_ "'`
if [ "$PIDS" ]
  then kill $PIDS
fi
