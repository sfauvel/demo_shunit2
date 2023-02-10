#! /bin/bash

function_called() {
    echo "Function called"
}

function_all_parameters() {
    echo "Function called with parameters $*"
}

function_extract_second_parameter() {
    echo "Function extract second parameter $2"
}

function_extract_parameters_except_the_first() {
    echo "Function extract second parameter ${@:2}"
}

test_call_a_function() {
  assertEquals \
    "Function called" \
    "$(function_called)"
}

test_pass_parameters_to_a_function() {
  assertEquals \
    "Function called with parameters abc 123" \
    "$(function_all_parameters abc 123)"
}

test_extract_one_parameter() {
  assertEquals \
    "Function extract second parameter 123" \
    "$(function_extract_second_parameter abc 123)"
}

test_keep_all_parameters_except_the_first() {
  assertEquals "Function extract second parameter 123 xyz 789" "$(function_extract_parameters_except_the_first abc 123 xyz 789)"
}

# Load and run shUnit2.
SHUNIT2_PATH=../../shunit2
. ${SHUNIT2_PATH}/shunit2
