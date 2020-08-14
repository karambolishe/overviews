#!/bin/bash -x

ENV=dev
LOCATION=westeurope
RESOURCE_GROUP_NAME=rg-overviews-tf-$ENV
STORAGE_ACCOUNT_NAME=overviewstf$ENV
CONTAINER_NAME=overviews-$ENV

if [ -z "$ENVIRONMENT" ]; then
  echo "ENVIRONMENT variable didn't set. It must be set before script starting for create azure resources"
  exit 0
fi

# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location $LOCATION

# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Get storage account key
ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query [0].value -o tsv)

# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME --account-key $ACCOUNT_KEY

echo "storage_account_name: $STORAGE_ACCOUNT_NAME"
echo "container_name: $CONTAINER_NAME"
echo "access_key: $ACCOUNT_KEY"
