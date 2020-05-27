#! /bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NO_COLOR='\033[0m' # No Color

FAILING_FILES=""
for testfile in ./*_test.sh
do
    echo "-----------------------"
    echo ${testfile}
    echo "-----------------------"

    RESULT="$($testfile)"
    
    echo "$RESULT"
    
    if [[ "$RESULT" =~ FAILED ]]       
    then  
        FAILING_FILES="$FAILING_FILES $testfile"
    fi
    if [[ -z "$RESULT" ]]; then

        echo -e "${RED}No result for $testfile\nFAILED\n${NO_COLOR}"
        FAILING_FILES="$FAILING_FILES $testfile"
    fi
done

if [[ -n $FAILING_FILES ]]
then
    echo -e "$RED"
    echo Failing tests:
    for failing in $FAILING_FILES
    do
        echo $failing
    done

else
    echo -e "$GREEN"
    echo All tests passed
fi 

echo -e "$NO_COLOR"