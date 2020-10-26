#! /bin/bash

test_grep_process_excluding_current_grep_process() {
  # https://www.cyberciti.biz/tips/grepping-ps-output-without-getting-grep.html
  # To filter process, ewe can use 'ps' and 'grep'
  # The problem is the command with grep contains search string

  assertContains "$(ps -ef | grep bash)" "grep "

  # [b]ash means find the character 'b' following by 'ash'. 
  # The command grep [b]ash not contains 'bash' so command is excluded from grep.
  assertNotContains "$(ps -ef | grep [b]ash)" "grep "

}

test_grep_process_pid() {
  # To extract second column, we can use awk
  PID_LIST="$(ps -ef | grep [b]ash | awk '{print $2}')"
  
  REGEXP="^[0-9]+$"

  OLD_IFS="$IFS"
  IFS=$'\n'

  FAILURE=""
  for PID in $PID_LIST; do
    if [[ ! "$PID" =~ $REGEXP ]]; then FAILURE="${FAILURE}\nPid:$PID is not a number"; fi
  done
  IFS=$OLD_IFS

  assertEquals "" "$FAILURE"
}

# Load and run shUnit2.
SHUNIT2_PATH=../../shunit2
. ${SHUNIT2_PATH}/shunit2


