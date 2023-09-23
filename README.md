# Purpose
This repo can be used to quickly bootstrap a CI/CD setup (and more) using argocd and tekton.
The installation manifests are generated with helmfile + helm/kustomize and deployed with argocd.

# Prerequisites
First, you need a running kubernetes cluster to deploy the apps to. If you use my [minikube repo](https://github.com/OlGe404/minikube) 
to install it, the configs (Ingress, Storage, etc.) for all apps in this repo will work out of the box.

Second, you need these CLI tools to generate the deployment manifests for all apps:
* make
* helmfile
* helm
* kubectl
* kustomize (comes with kubectl)

# Bootstrapping
To let argocd manage our apps, we need to install it first. You should check that you are logged in
to the correct cluster because this can be a potentially destructive operation.

Run `kubectl config current-context` to see which kubernetes cluster you are logged in to. If it's the correct cluster, run `cd $(git rev-parse --show-toplevel) && make bootstrap` to install argocd.

After ArgoCD is up and running, it will start to deploy all manifests defined in `templated/<CLUSTER>/*.yaml`. The applicationset controller will generate one argocd app per manifest found.

The applicationset controller reconciles the changes in git periodically, but if you want to trigger it manually run

```bash
kubectl delete pod -n argocd -l app.kubernetes.io/component=applicationset-controller
```

to delete the pod which forces a reconciliation loop on boot.


## ArgoCD login
After argocd is up and running, you can visit [the argocd UI](http://argocd.test) to login.
The initial username is "admin" and the password can be retrieved with

```bash
kubectl get secret -n argocd argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d  | xargs printf '%s \n'
```

# Add more apps
To add more apps, checkout how the other apps are defined, e.g. [argocd](apps/argocd/helmfile.yaml) and write a helmfile for your new app.

Afterwards, run `cd $(git rev-parse --show-toplevel) && make` to template and write the manifests to
`templates/localhost/<appName>.yaml`. The make target will add and commit the generated files for you,
you only have to push them manually. Once they are generated and pushed, the applicationset controller
will generate the application and argocd deploys them.


# Add more environments
The goal of this repo is to quickly and easily generate/deploy argocd apps for local development purposes.
However, the setup can easily be extended to work with any number of kubernetes clusters, locally or remote.

To add a new environemnt (kubernetes cluster), add it to the [environments.yaml conf file](helmfile.d/environments.yaml) used by helmfile.
You can then bootstrap the gitops setup as described in the #Bootstrapping section. The make target(s) and
applicationset conf will work out-of-the-box with more than one environment and generate/create argocd applications
automatically for each environment.

# Template a specific app
To generate the templates for all apps, run `make`.
To generate the templates for a specific app, run `SELECTOR="<key>=<value> make`. The key/values can be found
by inspecting the "labels" for the releases in the helmfiles.
