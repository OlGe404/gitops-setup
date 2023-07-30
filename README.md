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

We can now see that argocd already started to manage out apps, because they were generated according to the
applicationset resources. If we add a new folder within a stage, e. g. `local-dev/<new_folder>`,
the corresponding argocd application will be created automatically.
