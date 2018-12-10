#!/bin/bash
GREP_RESULT=$(docker image ls -a | grep "<none>")
test -z "${GREP_RESULT}" || echo ${GREP_RESULT} | awk '{print $3}' | xargs docker rmi
