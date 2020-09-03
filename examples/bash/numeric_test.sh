#! /bin/bash

test_compare_numeric() {
  assertTrue "[[ 5 -lt 10 ]]"
  assertTrue "[[ 5 -gt 3 ]]"
  assertTrue "[[ 5 -eq 5 ]]"
}


test_compare_numeric_variable() {
  FIVE=5
  TEN=10
  assertTrue "[[ $FIVE -lt $TEN ]]"
  assertTrue "[[ $TEN -gt $FIVE ]]"
  assertTrue "[[ $FIVE -eq $FIVE ]]"
}

test_increment() {
  FIVE=5
  SIX=$FIVE+3
  assertTrue "[[ $SIX -eq 8 ]]"
}

# Load and run shUnit2.
SHUNIT2_PATH=../../shunit2
. ${SHUNIT2_PATH}/shunit2

