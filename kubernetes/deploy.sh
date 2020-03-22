#!/bin/bash

NAMESPACE="swachalit"
MYSQL_ROOT_PASSWORD=$(openssl rand -base64 48)

kubectl create namespace $NAMESPACE

k() {
  kubectl --namespace $NAMESPACE "$@"
}


k create secret generic mysql-secret --from-literal=MYSQL_ROOT_PASSWORD="$MYSQL_ROOT_PASSWORD"
k create secret generic swachalit-env --from-env-file=.env

k apply -f manifests/
