# Purpose
This repo can be used to bootstrap a CI/CD setup (and more) using argocd and tekton.
The state of the installations is managed in a gitops-manner with helmfile and argocd.

# Prerequisites
You need access to a kubernetes cluster and the kubectl cli.
Checkout my [microk8s repo](https://github.com/OlGe404/microk8s) or [minikube repo](https://github.com/OlGe404/minikube) to quickly
install and setup a local kubernetes cluster with one command.

# Bootstrapping
To let argocd manage our apps, we need to template and install the YAML manifests for it first.

**Ensure** you are logged in to the correct kubernetes cluster, because this will be a desctructive operation
in the wrong kube context.

Run:

```bash
cd $(git rev-parse --show-toplevel)
make bootstrap
```

To create all deployments managed 

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
