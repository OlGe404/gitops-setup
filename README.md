# Purpose
This repo can be used to quickly bootstrap a CI/CD setup (and more) using argocd and tekton.
The installation manifests are generated with helmfile and deployed with argocd.

# Prerequisites
First, you need a running kubernetes cluster to deploy the apps to. If you use my [minikube repo](https://github.com/OlGe404/minikube) 
to install it, the configs (Ingress, Storage, etc.) for all apps in this repo will work out of the box.

Second, you need these CLI tools:
* make
* helmfile
* helm
* kubectl
* kustomize (comes with kubectl)

# Bootstrapping
To let argocd manage our apps, we need to install it first. You should check that you are logged in
to the correct cluster because this can be a potentially destructive operation.

Run `kubectl config current-context` to see which kubernetes cluster you are logged in.

To install argocd, run `cd $(git rev-parse --show-toplevel) && make bootstrap`. After ArgoCD is up and running,
it will start deployen all manifests defined in `templated/localhost/*/all.yaml`.


## ArgoCD login
After all argocd pods are up and running, you can visit [the argocd UI](http://argocd.test) to login.
The initial username is "admin" and the password can be retrieved with

```bash
# Get password for the initial argocd admin user
kubectl get secret -n argocd argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d  | xargs printf '%s \n'
```

# Add more apps
To add more apps to this gitops-setup, checkout how the other apps are defined, e.g. [argocd](apps/argocd/helmfile.yaml)
and write a helmfile for your new app.

Afterwards, run `cd $(git rev-parse --show-toplevel) && make` to template and write the manifests to
`templates/localhost/<appName>/all.yaml`. The make target will add and commit the generated files for you.
If you push them to the repository, argocd will pick them up automatically.
