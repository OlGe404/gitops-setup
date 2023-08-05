# Purpose

# Prerequisites

# Bootstrapping
To let argocd manage our apps, we need to install argocd in our cluster:

```bash
# Deploy argocd and create the applicationsets
kubectl apply -k local-dev/argocd/
```

After all argocd pods are up and running, we can visit `http://localhost:30002` to login.
The initial username is "admin" and the password can be retrieved as follows:

```bash
# Get password for argocd admin user
kubectl get secret -n argocd argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d 
```

We can now see that argocd starts to manage our apps, because they were generated from the applicationset.
To add additional argocd apps, just add a folder inside localhost/ with the kustomization.yaml file describing your deployment.
