#!/bin/bash

CLUSTER=$1
SELECTOR=$2

for helmfile in apps/*/helmfile.yaml; do
    APPNAME=$(echo $helmfile | cut -d '/' -f2)
    TEMPLATED=$(helmfile template -e $CLUSTER -f $helmfile -l $SELECTOR --include-crds) 
    
    if [[ -n $TEMPLATED ]]; then
        mkdir -p templated/$CLUSTER/$APPNAME
        echo "$TEMPLATED" > templated/$CLUSTER/$APPNAME/all.yaml
    fi
done
