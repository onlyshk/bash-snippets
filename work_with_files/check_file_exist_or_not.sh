# Name : Vikas V
# Function : checkFileExistorNot()
# Purpose  : This function will check whether the file exist at following path or not 
# Execution : This function takes two parameter's from user i] path ii] file name.Just replace the calling function parameter's which are defined at the end and run the script via following command : sh check_file_exist_or_not.sh
# Creation  : 10-04-2020     

#!/bin/bash

checkFileExistorNot()
{

# Parameters defined 
InputPath=$1
InputFilename=$2 

# Checking the parameters entered from user or not
if [ -z ${InputPath} ]
then
    echo "Fail    : Path : $InputPath : Parameter is not defined "
else
    echo "Success : Path : $InputPath : Parameter is defined"
fi 

if [ -z ${InputFilename} ]
then
    echo "Fail    : Path : $InputFilename : Parameter is not defined "  
else
    echo "Success : Path : $InputFilename : Parameter is defined"
fi 

[ -d $InputPath ] > /dev/null
statuschk=$?

if [ $statuschk -eq 0 ]
then 
    
    echo "Checking started ....."

    # Checking the file exist at path or not 
    [  -f $InputPath/$InputFilename ] > /dev/null 
    
    status=$?
    if [ $status -eq 0 ]
    then
    echo "Success : File : $InputFilename  exist at following path : $InputPath"
    else    
    echo "Fail    : File : $InputFilename  does not exist at following path : $InputPath"
    fi       

else
    
    echo "Entered path : $InputPath  does not exist, please enter valid path"

fi    

}

# Calling function 
checkFileExistorNot '/abc/' 'F_function_list.txt'




