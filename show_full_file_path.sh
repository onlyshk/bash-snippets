#!/bin/bash

# Shows the full path of files
# good for copy pasting and for when
# listing the full paths is necessary.

for file in $(ls "$@"); do
        echo -n $(pwd)
        [[ $(pwd) != "/" ]] && echo -n /
        echo $file
done
