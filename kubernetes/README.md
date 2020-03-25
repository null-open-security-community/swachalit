# WIP: Kubernetes Manifests

## Requirements

* Kubernetes Cluster
* `kubectl` configured to use the cluster

Verify:

```
kubectl cluster-info
```

## Deployment

Create or copy environment file

```
cp ../.env .env
```

Create resources

```
./deploy.sh
```

## Cleanup

```
kubectl delete namespace swachalit
```

