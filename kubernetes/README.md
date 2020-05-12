# Kubernetes Manifests

## Requirements

* Kubernetes Cluster
* `kubectl` configured to use the cluster

Verify:

```
kubectl cluster-info
```

## Deployment

Create a file `.env.app` using example from [Developer Documentation](https://github.com/null-open-security-community/swachalit/blob/master/doc/developer-guide-docker-compose.md)

Create a file `.env.mysql` using below command

```
echo "MYSQL_ROOT_PASSWORD=$(openssl rand -hex 12)" > .env.mysql
```

Execute deployment

```
kubectl apply -k .
```

## Cleanup

```
kubectl delete -k .
```
