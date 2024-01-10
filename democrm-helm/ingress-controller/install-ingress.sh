#!/bin/bash
helm install --create-namespace -n ingress ingress nginx-ingress-controller-9.2.1.tgz -f my-values.yaml
until kubectl get svc -n ingress | grep LoadBalancer | grep -v "pending"
do
  echo Awaiting pending LoadBalancer...
  sleep 5
done
echo -------------------------
echo LoadBalancer external IP:
kubectl -n ingress get svc ingress-nginx-ingress-controller -o jsonpath="{.status.loadBalancer.ingress[0].ip}"
echo
echo -------------------------
