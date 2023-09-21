#!/bin/bash

ENV=$1

for helmfile in apps/*/helmfile.yaml; do
    appName=$(echo $helmfile | cut -d '/' -f2)
    mkdir -p templated/$ENV/$appName
    helmfile template -e $ENV -f $helmfile --include-crds > templated/$ENV/$appName/all.yaml
done
