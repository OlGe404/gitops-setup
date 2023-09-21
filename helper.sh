#!/bin/bash

ENV=$1

for helmfile in apps/*/helmfile.yaml; do
    appName=$(echo $helmfile | cut -d '/' -f2)
    mkdir -p templated/$ENV/$appName
    helmfile template -e $ENV --include-crds > templated/$ENV/$appName/all.yaml
    cd templated/$ENV/$appName && cat all.yaml | yq --split-exp '(.kind | downcase) + "-" + .metadata.name + ".yaml"'
    rm all.yaml
done
