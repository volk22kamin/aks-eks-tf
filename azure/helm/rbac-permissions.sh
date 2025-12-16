#!/usr/bin/env bash
set -euo pipefail

RESOURCE_GROUP="prod-aks-rg"
CLUSTER_NAME="prod-aks-cluster"
APPGW_NAME="prod-aks-cluster-appgw"
VNET_NAME="prod-aks-vnet"
SUBNET_NAME="prod-aks-appgw-subnet"
SUBSCRIPTION_ID="${SUBSCRIPTION_ID:-$(az account show --query id -o tsv)}"

AGIC_OBJECT_ID=$(az aks show \
  -g "$RESOURCE_GROUP" \
  -n "$CLUSTER_NAME" \
  --query addonProfiles.ingressApplicationGateway.identity.objectId \
  -o tsv)

APPGW_ID="/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.Network/applicationGateways/$APPGW_NAME"
RESOURCE_GROUP_SCOPE="/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP"
APPGW_SUBNET_ID="/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.Network/virtualNetworks/$VNET_NAME/subnets/$SUBNET_NAME"

az role assignment create \
  --assignee-object-id "$AGIC_OBJECT_ID" \
  --assignee-principal-type ServicePrincipal \
  --role Contributor \
  --scope "$APPGW_ID"

az role assignment create \
  --assignee-object-id "$AGIC_OBJECT_ID" \
  --assignee-principal-type ServicePrincipal \
  --role Reader \
  --scope "$RESOURCE_GROUP_SCOPE"

az role assignment create \
  --assignee-object-id "$AGIC_OBJECT_ID" \
  --assignee-principal-type ServicePrincipal \
  --role Contributor \
  --scope "$RESOURCE_GROUP_SCOPE"

az role assignment create \
  --assignee-object-id "$AGIC_OBJECT_ID" \
  --assignee-principal-type ServicePrincipal \
  --role "Network Contributor" \
  --scope "$APPGW_SUBNET_ID"

kubectl -n kube-system scale deployment ingress-appgw-deployment --replicas=0
sleep 120
kubectl -n kube-system scale deployment ingress-appgw-deployment --replicas=1