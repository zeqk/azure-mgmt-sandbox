This project is to try out the use of Terraform in Azure Cloud

## Create state storage 

```powershell
$RESOURCE_GROUP_NAME="rg-tfstates-iprd-ue"
$STORAGE_ACCOUNT_NAME="sremanuallymanaged"
$CONTAINER_NAME="terraformstates"

# Create resource group
# az group create --name $RESOURCE_GROUP_NAME --location eastus

# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Get storage account key
$ACCOUNT_KEY=(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv)
echo $ACCOUNT_KEY
# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME --account-key $ACCOUNT_KEY

echo "storage_account_name: $STORAGE_ACCOUNT_NAME"
echo "container_name: $CONTAINER_NAME"
echo "access_key: $ACCOUNT_KEY"

```

## Init

```powershell
$PROD_SUBSCRIPTION_ID=(az account list --query "[?name == ``Sistemas - Production``].id" -o tsv)
$ACCOUNT_KEY=(az storage account keys list --subscription $PROD_SUBSCRIPTION_ID --resource-group "rg-tfstates-iprd-ue" --account-name "sremanuallymanaged" --query '[0].value' -o tsv)

echo $PROD_SUBSCRIPTION_ID
echo $ACCOUNT_KEY

terraform -chdir="./sandbox" init `
    -backend-config="subscription_id=$PROD_SUBSCRIPTION_ID" `
    -backend-config="access_key=$ACCESS_KEY"
```

## Deploy

```powershell
# Set variables
$env:TF_VAR_tenant_id=(az account list --query "[?name == ``Sistemas - Non Production``].tenantId" -o tsv)
$env:TF_VAR_subscription_id=(az account list --query "[?name == ``Sistemas - Non Production``].id" -o tsv)

# Validate
terraform -chdir="./sandbox" validate

# Plan
terraform -chdir="./sandbox" plan

# Apply
terraform -chdir="./sandbox" apply -auto-approve

# Destroy plan
terraform -chdir="./sandbox" plan -destroy

# Destroy
terraform -chdir="./sandbox" destroy -auto-approve

```

## Other commands

```powershell
az account set --subscription $(az account list --query "[?name == ``Sistemas - Non Production``].id" -o tsv)
```