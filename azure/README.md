# Azure AKS Infrastructure with Terraform

This directory contains Terraform configurations for deploying a complete Azure AKS (Azure Kubernetes Service) infrastructure with VNet networking, cluster setup, Application Gateway, and Helm chart deployments.

## 📁 Directory Structure

```
azure/
├── backend-storage/     # Azure Storage Account for Terraform state
├── vnet/                # VNet, subnets, NAT Gateway, and networking
├── cluster/             # AKS cluster and Application Gateway
└── helm/                # Helm chart deployments (AGIC, apps)
```

## 🏗️ Module Overview

### 1. **backend-storage** - Terraform State Backend

**Purpose**: Creates Azure Storage Account and container for storing Terraform state files.

**Resources Created**:

- Resource Group for state storage
- Storage Account with versioning
- Blob container for state files

**Key Features**:

- Multi-environment support (dev, staging, prod)
- Blob versioning enabled
- TLS 1.2 minimum version
- LRS (Locally Redundant Storage) replication
- Private container access

**Module Location**: `./backend-storage/`

---

### 2. **vnet** - Virtual Network

**Purpose**: Creates the networking foundation for the AKS cluster.

**Resources Created**:

- Resource Group for networking resources
- Virtual Network (VNet)
- Public subnets (for Application Gateway)
- Private subnets (for AKS nodes)
- NAT Gateway (for private subnet internet access)
- Public IP for NAT Gateway
- Route tables and associations

**Key Features**:

- Address space: `10.0.0.0/16`
- Configurable number of public/private subnets
- Multi-AZ deployment for high availability
- Dedicated subnet for Application Gateway
- Proper tagging for AKS cluster discovery

**Module Location**: `./vnet/modules/vnet/`

**State Storage**: Remote state stored in Azure Storage (`vnet.tfstate`)

---

### 3. **cluster** - AKS Cluster & Application Gateway

**Purpose**: Deploys the AKS cluster with Application Gateway for ingress.

**Resources Created**:

- AKS cluster with managed identity
- System node pool
- Application Gateway (v2)
- Public IP for Application Gateway
- User-assigned managed identity for AGIC
- Role assignments for networking permissions

**Key Features**:

- Kubernetes version configurable
- Managed identity (no service principals)
- Application Gateway Ingress Controller (AGIC)
- Integration with VNet private subnets
- Azure CNI networking
- RBAC enabled

**Module Location**: `./cluster/modules/aks/`

**Dependencies**: Reads VNet state from remote state

**State Storage**: Remote state stored in Azure Storage (`cluster.tfstate`)

---

### 4. **helm** - Helm Chart Deployments

**Purpose**: Deploys Kubernetes applications using Helm and configures AGIC.

**Resources Deployed**:

- Hello World application (sample app)
- Kubernetes Ingress resource for Application Gateway
- RBAC permissions setup

**Key Features**:

- Automated Application Gateway configuration via ingress
- RBAC permissions for AGIC
- Helm chart version management
- Ingress configuration for HTTP routing

**Module Location**: `./helm/modules/helm-chart/`

**Dependencies**: Reads cluster state from remote state

**Special Note**: Includes `rbac-permissions.sh` script for setting up required permissions

---

## 🚀 Deployment Steps

Follow these steps in order to deploy the complete infrastructure:

### **Step 1: Deploy Backend Storage**

```bash
cd backend-storage
terraform init
terraform plan
terraform apply
```

**What it does**: Creates Storage Account and container for state management.

**Manual Input Required**: None (first deployment)

**Outputs**:

- Resource Group name
- Storage Account name
- Container name

---

### **Step 2: Deploy VNet**

```bash
cd ../vnet
terraform init
terraform plan
terraform apply
```

**What it does**: Creates VNet, subnets, NAT Gateway, and all networking components.

**Manual Input Required**:

**All manual changes already applied**

- Update `backend.tf` with your Storage Account details from Step 1
- Update `variable.auto.tfvars` with desired configuration

**Backend Configuration** (`backend.tf`):

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "YOUR-RG-NAME"          # From backend-storage output
    storage_account_name = "YOUR-STORAGE-ACCOUNT"  # From backend-storage output
    container_name       = "tfstate"               # From backend-storage output
    key                  = "vnet.tfstate"
  }
}
```

**Outputs**:

- VNet ID
- Public/private subnet IDs
- Application Gateway subnet ID
- Resource Group name
- Location

---

### **Step 3: Deploy AKS Cluster**

```bash
cd ../cluster
terraform init
terraform plan
terraform apply
```

**What it does**: Creates AKS cluster, Application Gateway, and managed identities.

**Manual Input Required**:

- Update `backend.tf` with your Storage Account configuration
- Update `variable.auto.tfvars` with:
  - VNet state resource group name
  - VNet state storage account name
  - VNet state container name
  - VNet state key (`vnet.tfstate`)

**Backend Configuration** (`backend.tf`):

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "YOUR-RG-NAME"
    storage_account_name = "YOUR-STORAGE-ACCOUNT"
    container_name       = "tfstate"
    key                  = "cluster.tfstate"
  }
}
```

**Data Source Configuration** (`data.tf`):

```hcl
# Reads VNet outputs from remote state
data "terraform_remote_state" "vnet" {
  backend = "azurerm"
  config = {
    resource_group_name  = "YOUR-RG-NAME"          # Same as backend
    storage_account_name = "YOUR-STORAGE-ACCOUNT"  # Same as backend
    container_name       = "tfstate"
    key                  = "vnet.tfstate"          # VNet state key
  }
}
```

**Outputs**:

- AKS cluster ID
- AKS cluster name
- Application Gateway ID
- Managed identity IDs

---

### **Step 4: Deploy Helm Charts**

```bash
cd ../helm

# First, configure kubectl to access the cluster
az aks get-credentials --resource-group <rg-name> --name <cluster-name>

# Then deploy Helm charts
terraform init
terraform plan
terraform apply
```

**What it does**: Deploys sample application and configures ingress.

**Manual Input Required**:

- Update `backend.tf` with your Storage Account configuration
- Update `variable.auto.tfvars` with:
  - Cluster state resource group name
  - Cluster state storage account name
  - Cluster state container name
  - Cluster state key (`cluster.tfstate`)
- Ensure kubectl is configured (see command above)

**Backend Configuration** (`backend.tf`):

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "YOUR-RG-NAME"
    storage_account_name = "YOUR-STORAGE-ACCOUNT"
    container_name       = "tfstate"
    key                  = "helm.tfstate"
  }
}
```

**Data Source Configuration** (`data.tf`):

```hcl
# Reads cluster outputs from remote state
data "terraform_remote_state" "cluster" {
  backend = "azurerm"
  config = {
    resource_group_name  = "YOUR-RG-NAME"
    storage_account_name = "YOUR-STORAGE-ACCOUNT"
    container_name       = "tfstate"
    key                  = "cluster.tfstate"
  }
}
```

**Outputs**:

- Helm release names
- Application endpoints

---

## 🔧 Manual Configuration Required

### Why Backend Configs Must Be Manually Updated

Terraform backend configurations **cannot use variables** because they are initialized before Terraform evaluates variables. This is a Terraform limitation, not a design choice.
