# Purpose
This repo can be used to quickly bootstrap a full CI/CD setup using argocd and tekton on a local kubernetes installation,
managed in a gitops way of deploying kubernetes apps.

# Prerequisites
A kubernetes installation + kubectl. Checkout the [microk8s repo](https://github.com/OlGe404/microk8s) to install and setup kubernetes.

# Bootstrapping
To let argocd manage our apps, we need to install it:

```bash
cd $(git rev-parse --show-toplevel) && kubectl apply -k localhost/argocd/
```

Depending on how fast the argocd CRDs are established in your cluster, you might need to run the above command
twice in a row to deploy the applicationset resource without getting an error.

## ArgoCD login
After all argocd pods are up and running, you can visit [the argocd UI](http://localhost:30002) to login.
The initial username is "admin" and the password can be retrieved as follows:

```bash
# Get password for the initial argocd admin user
kubectl get secret -n argocd argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d 
```

We can now see that argocd is starting to manage our apps, because they were generated from the applicationset.
To deploy additional argocd apps, just add a folder inside localhost/ with the kustomization.yaml file describing your deployment.
The applicationset controller will reconcile this repo every 3 minutes and automatically create the argocd applications for you
based on the folders found.

## Tekton dashboard
Tekton will be installed alongside argocd to have a fully fledged CI/CD setup running.
The tekton-dashboard UI will be available [here](http://localhost:30003).
