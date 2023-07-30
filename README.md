# Purpose

# Prerequisites

# Bootstrapping
```bash
# Deploy argocd and generate argocd applications
kubectl apply -k local-dev/argocd/
```

```bash
# Get password for argocd admin user
kubectl get secret -n argocd argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d
```

# Add new apps

# Configure each app
