#! /bin/bash

# https://www.networkworld.com/article/2693361/unix-tip-using-bash-s-regular-expressions.html

test_regexp_multi() {
  REGEXP="^A(BC)*BDE$"
  assertTrue "[[ "ABCBCBCBDE" =~ $REGEXP ]]"
  assertTrue "[[ "ABDE" =~ $REGEXP ]]"
  assertTrue "[[ "ABCBDE" =~ $REGEXP ]]"
}

test_regexp_or() {
  REGEXP="^A((BD(E|F)G)|C)$"
  assertTrue "[[ "ABDEG" =~ $REGEXP ]]"
  assertTrue "[[ "ABDFG" =~ $REGEXP ]]"
  assertTrue "[[ "AC" =~ $REGEXP ]]"
}

test_regexp_with_space() {
  REGEXP="^A B C$"
  if [[ ! "A B C" =~ $REGEXP ]]; then
    fail "Not match"
  fi
}

# Load and run shUnit2.
SHUNIT2_PATH=../../shunit2
. ${SHUNIT2_PATH}/shunit2

