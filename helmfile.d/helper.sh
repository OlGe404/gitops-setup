#!/bin/bash

ENV=$1

mkdir -p templated/$ENV

for helmfile in apps/*/helmfile.yaml; do
    appName=$(echo $helmfile | cut -d '/' -f2)
    helmfile template -e $ENV -f $helmfile --include-crds > templated/$ENV/$appName.yaml
done
