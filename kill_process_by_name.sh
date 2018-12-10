#!/bin/bash
echo "Please enter your process to find:"
read PROCESS_NAME

GREP_RESULT=$(ps -ef | grep "$PROCESS_NAME" | grep -v "grep")
test -z "${GREP_RESULT}" || echo ${GREP_RESULT} | awk '{print $2}' | xargs kill -9
