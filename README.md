This project is to try out the use of Terraform in Azure Cloud

Requirements:
- Powershell
- Azure CLI
- Terraform
## Create state storage 

```powershell
$RESOURCE_GROUP_NAME="rg-tfstates-iprd-ue"
$STORAGE_ACCOUNT_NAME="sttfstatesiprdue"
$CONTAINER_NAME="tfstates"

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

### Load vars

Powershell

```powershell
$TENANT_ID=(az account list --query "[?name == ``Sistemas - Production``].tenantId" -o tsv)
$PROD_SUBSCRIPTION_ID=(az account list --query "[?name == ``Sistemas - Production``].id" -o tsv)
$NONPROD_SUBSCRIPTION_ID=(az account list --query "[?name == ``Sistemas - Non Production``].id" -o tsv)
$RESOURCE_GROUP_NAME="rg-tfstates-iprd-ue"
$STORAGE_ACCOUNT_NAME="sttfstatesiprdue"
$STORAGE_CONTAINER_NAME="tfstates"
$STATE_FILE_PATH="azure-cloud-sandbox/terraform.tfstate"
$STORAGE_ACCOUNT_KEY=(az storage account keys list `
                        --subscription $PROD_SUBSCRIPTION_ID `
                        --resource-group $RESOURCE_GROUP_NAME `
                        --account-name $STORAGE_ACCOUNT_NAME `
                        --query '[0].value' -o tsv)
$env:TF_VAR_tenant_id="$TENANT_ID"
$env:TF_VAR_subscription_id="$NONPROD_SUBSCRIPTION_ID"

```

Bash

```bash
TENANT_ID=$(az account list --query "[?name == 'Sistemas - Production'].tenantId" -o tsv)
PROD_SUBSCRIPTION_ID=$(az account list --query "[?name == 'Sistemas - Production'].id" -o tsv)
NONPROD_SUBSCRIPTION_ID=$(az account list --query "[?name == 'Sistemas - Non Production'].id" -o tsv)
RESOURCE_GROUP_NAME="rg-tfstates-iprd-ue"
STORAGE_ACCOUNT_NAME="sttfstatesiprdue"
STORAGE_CONTAINER_NAME="tfstates"
STATE_FILE_PATH="azure-cloud-sandbox/terraform.tfstate"
STORAGE_ACCOUNT_KEY=$(az storage account keys list \
                        --subscription $PROD_SUBSCRIPTION_ID \
                        --resource-group "$RESOURCE_GROUP_NAME" \
                        --account-name "$STORAGE_ACCOUNT_NAME" \
                        --query '[0].value' -o tsv)
export TF_VAR_tenant_id="$TENANT_ID"
export TF_VAR_subscription_id="$NONPROD_SUBSCRIPTION_ID"

```

## Init

```powershell
terraform -chdir="./sandbox" init \
    -backend-config="resource_group_name=$RESOURCE_GROUP_NAME" `
    -backend-config="storage_account_name=$STORAGE_ACCOUNT_NAME" `
    -backend-config="container_name=$STORAGE_CONTAINER_NAME" `
    -backend-config="key=$STATE_FILE_PATH" `
    -backend-config="access_key=$STORAGE_ACCOUNT_KEY"
```

```bash
terraform -chdir="./sandbox" init \
    -backend-config="resource_group_name=$RESOURCE_GROUP_NAME" \
    -backend-config="storage_account_name=$STORAGE_ACCOUNT_NAME" \
    -backend-config="container_name=$STORAGE_CONTAINER_NAME" \
    -backend-config="key=$STATE_FILE_PATH" \
    -backend-config="access_key=$STORAGE_ACCOUNT_KEY"
```

## Deploy


```console
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

# Show output
terraform -chdir="./sandbox" output webapi_pgpassword

```

## Other commands

```powershell
az account set --subscription $(az account list --query "[?name == ``Sistemas - Non Production``].id" -o tsv)
```