#!/bin/bash

# Remove all tmp files in dir
# which end in ~

echo "Input dir in which remove all temp files: " 
read DIR;
find "$DIR" -name "*~" -exec rm -f {} \;
echo "All temp files are removed"

