#!/bin/sh

if [ -z `which git` ]; then
    echo 'You have to install git first.'
    return
fi

template_path="$1"
echo "Now we are going to create a new project for you".
if [ -z "$template_path" ]; then
    echo "Enter the desired path of your new project dir:"
    read template_path
fi

# switch to the new project dir
cd "$template_path"
# remove unnecessary files
mv tmp/template/* .
rm -rf tmp

echo
echo Initializing your new project...

echo 'Enter the binary name of your program. This is the name of the binary flie installed to /usr/bin:'
read bin_name
if [ -z "$bin_name" ]; then
    echo 'Please enter a valid name.'
    return
fi

echo 'Enter a human readable name of your program ':
read prog_name
if [ -z "$prog_name" ]; then
    echo 'Please enter a valid name.'
    return
fi

echo 'Enter a short description for your program (such as "A tool to configure mouse and keyboard")':
read prog_desc
if [ -z "$prog_desc" ]; then
    echo 'Please enter a valid description.'
    return
fi

bin_name_=`echo $bin_name | sed s/-/_/`_

for f in `ls ./configure.ac ./src/*.c ./src/*.am ./data/*.am ./data/*.in ./data/ui/*.am ./data/ui/*.in`; do
    sed -e s/template_/"$bin_name_"/ -e s/template/"$bin_name"/ -e s/Template/"$prog_name"/ -e "s/Template Description/$prog_desc/" "$f" > "$f".tmp
    mv "$f".tmp "$f"
done

# rename files
mv src/template.c src/"$bin_name".c
mv data/template.desktop.in data/"$bin_name".desktop.in

# remove git files.
rm -rf .git

echo Done!
