#! /bin/bash

test_loop_in_range() {
 
  RESULT=""
  for i in {1..5}; do RESULT="${RESULT}$i,"; done
  assertEquals "1,2,3,4,5," "${RESULT}"
}

test_loop_in_range_using_variable() { 
  RESULT=""
  END=5
  for i in $(seq 1 $END); do RESULT="${RESULT}$i,"; done
  assertEquals "1,2,3,4,5," "${RESULT}"
}

# Load and run shUnit2.
SHUNIT2_PATH=../../shunit2
. ${SHUNIT2_PATH}/shunit2


