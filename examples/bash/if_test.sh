#! /bin/bash

test_if_variable_not_exist() {
  unset TOTO
  if [[ -z $TOTO ]]; then pass else fail "Should not exist"; fi
}


test_if_variable_exist() {
  TOTO="toto"
  if [[ -z $TOTO ]]; then fail "Variable should exist"; fi
}

test_if_with_or() {
  if [ 2 -eq 1 -o 4 -eq 5 ]; then fail "None are equals"; fi
  if [ 1 -eq 2 -o 5 -eq 5 ]; then pass; else fail "5 equals 5"; fi
  if [ 1 -eq 1 -o 4 -eq 5 ]; then pass; else fail "1 equals 1"; fi
  if [ 1 -eq 1 -o 5 -eq 5 ]; then pass; else fail "Both are equal"; fi
}

test_if_with_and() {
  if [ 2 -eq 1 -a 4 -eq 5 ]; then fail "None are equals"; fi
  if [ 1 -eq 2 -a 5 -eq 5 ]; then fail "1 not equals 2"; fi
  if [ 1 -eq 1 -a 4 -eq 5 ]; then fail "4 equals 5"; fi
  if [ 1 -eq 1 -a 5 -eq 5 ]; then pass; else fail "Both are equal"; fi
}

pass(){
  local OK
}

# Load and run shUnit2.
SHUNIT2_PATH=../../shunit2
. ${SHUNIT2_PATH}/shunit2


