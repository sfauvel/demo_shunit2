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

test_create_a_list() { 
  MY_LIST=("one" "two" "three" "fourty two")  
  assertEquals "one" "${MY_LIST[0]}"
  assertEquals "two" "${MY_LIST[1]}"
  assertEquals "three" "${MY_LIST[2]}"
  assertEquals "fourty two" "${MY_LIST[3]}"
  assertEquals "fourty two" "${MY_LIST[-1]}"

  RESULT=""
  SEPARATOR=""
  for text in "${MY_LIST[@]}"; do RESULT="${RESULT}${SEPARATOR}${text}";SEPARATOR=","; done
  assertEquals "one,two,three,fourty two" "${RESULT}"
}

# Load and run shUnit2.
SHUNIT2_PATH=../../shunit2
. ${SHUNIT2_PATH}/shunit2


