#! /bin/bash

test_if_variable_not_exist() {
  unset TOTO
  if [[ -z $TOTO ]]
  then
    # Variable not exist, it's ok
  else
    fail "Should not exist"   
  fi
}


test_if_variable_exist() {
  TOTO="toto"
  if [[ -z $TOTO ]]
  then
    fail "Variable should exist"  
  fi
}

# Load and run shUnit2.
SHUNIT2_PATH=../../shunit2
. ${SHUNIT2_PATH}/shunit2

