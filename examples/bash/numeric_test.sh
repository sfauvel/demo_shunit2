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

  EIGHT=$FIVE+3
  # With eq, variable is evaluated as numeric
  assertTrue "[[ $EIGHT -eq 8 ]]"
  assertTrue "[[ $EIGHT -eq "5+3" ]]"
  # With =, variable is compared as string
  assertTrue "[[ $EIGHT = "5+3" ]]"

  EIGHT_NUM=$(($FIVE+3))
  assertTrue "[[ $EIGHT_NUM = "8" ]]"
}

# Load and run shUnit2.
SHUNIT2_PATH=../../shunit2
. ${SHUNIT2_PATH}/shunit2

