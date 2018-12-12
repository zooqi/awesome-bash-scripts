#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Example: ./show_pod_log.sh <namespace> <pod_name_to_search>"
    exit 1
fi

NAMESPACE=$1
POD_NAME_TO_SEARCH=$2
NAMESPACE_SEARCH_RESULT=$(kubectl get namespaces | awk '{print $1}' | tail -n +2 | grep -w $NAMESPACE)

if [ -z "$NAMESPACE_SEARCH_RESULT" ]; then
    echo "No such namespace found: "$NAMESPACE
    exit 1
fi

POD_NAME=$(kubectl get pods -n $NAMESPACE | awk '{print $1}' | tail -n +2 | grep $POD_NAME_TO_SEARCH)

if [ -z "$POD_NAME" ]; then
    echo "No pod '"$POD_NAME_TO_SEARCH"' found in namespace: "$NAMESPACE
    exit 1
fi

POD_NAME=$(printf "$POD_NAME" | head -n 1)

run_and_log() {
     printf "$@\n"
     eval "$@"
}

run_and_log "kubectl logs -f --tail 200 -n $NAMESPACE $POD_NAME"
