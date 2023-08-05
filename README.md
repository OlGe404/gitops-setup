# Purpose

# Prerequisites
A kubernetes cluster + kubectl. Checkout the [microk8s repo](https://github.com/OlGe404/microk8s) to setup kubernetes.

# Bootstrapping
To let argocd manage our apps, we need to install argocd in our cluster:

```bash
cd $(git rev-parse --show-toplevel) && kubectl apply -k localhost/argocd/
```
Depending on how fast the argocd CRDs are established in your cluster, you might need to run the above command
twice in order to deploy the applicationset resource.

## ArgoCD login
After all argocd pods are up and running, we can visit [the argocd UI](http://localhost:30002) to login.
The initial username is "admin" and the password can be retrieved as follows:

```bash
# Get password for argocd admin user
kubectl get secret -n argocd argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d 
```

We can now see that argocd starts to manage our apps, because they were generated from the applicationset.
To add additional argocd apps, just add a folder inside localhost/ with the kustomization.yaml file describing your deployment.

## Tekton dashboard
Tekton will be installed alongside argocd to have a fully fledged CI/CD setup running.
The tekton-dashboard UI will be available [here](http://localhost:30003).