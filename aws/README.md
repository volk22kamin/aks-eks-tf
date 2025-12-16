# AWS EKS Infrastructure with Terraform

This directory contains Terraform configurations for deploying a complete AWS EKS (Elastic Kubernetes Service) infrastructure with VPC networking, cluster setup, and Helm chart deployments.

## 📁 Directory Structure

```
aws/
├── backend-s3/          # S3 backend for Terraform state storage
├── vpc/                 # VPC, subnets, NAT Gateway, and networking
├── cluster/             # EKS cluster and related resources
└── helm/                # Helm chart deployments (ALB controller, apps)
```

## 🏗️ Module Overview

### 1. **backend-s3** - Terraform State Backend

**Purpose**: Creates S3 buckets and DynamoDB table for storing Terraform state files with locking support.

**Resources Created**:

- S3 buckets with versioning and encryption
- DynamoDB table for state locking
- Public access blocking on S3 buckets

**Key Features**:

- Multi-environment support (dev, staging, prod)
- Server-side encryption (AES256)
- Versioning enabled for state recovery
- State locking via DynamoDB

**Module Location**: `./backend-s3/`

---

### 2. **vpc** - Virtual Private Cloud

**Purpose**: Creates the networking foundation for the EKS cluster.

**Resources Created**:

- VPC with DNS support and hostnames enabled
- Public subnets (for NAT Gateway and load balancers)
- Private subnets (for EKS worker nodes)
- Internet Gateway
- NAT Gateway (for private subnet internet access)
- Route tables and associations
- Security groups

**Key Features**:

- CIDR block: `10.0.0.0/16`
- Configurable number of public/private subnets
- Multi-AZ deployment for high availability
- Proper tagging for EKS cluster discovery

**Module Location**: `./vpc/modules/vpc/`

**State Storage**: Remote state stored in S3 (`vpc/terraform.tfstate`)

---

### 3. **cluster** - EKS Cluster

**Purpose**: Deploys the EKS cluster with Fargate profiles and IAM roles.

**Resources Created**:

- EKS cluster
- Fargate profiles for serverless pod execution
- IAM roles and policies for:
  - EKS cluster
  - Fargate pods
  - AWS Load Balancer Controller
- OIDC provider for IAM roles for service accounts (IRSA)

**Key Features**:

- Kubernetes version configurable
- Fargate-based workloads (no EC2 worker nodes)
- IAM roles for service accounts (IRSA)
- Integration with VPC private subnets
- AWS Load Balancer Controller IAM role

**Module Location**: `./cluster/modules/eks/`

**Dependencies**: Reads VPC state from remote state

**State Storage**: Remote state stored in S3 (`cluster/terraform.tfstate`)

---

### 4. **helm** - Helm Chart Deployments

**Purpose**: Deploys Kubernetes applications and controllers using Helm.

**Resources Deployed**:

- AWS Load Balancer Controller (for ALB ingress)
- Hello World application (sample app)
- Kubernetes Ingress resource

**Key Features**:

- Automated ALB provisioning via ingress
- Service account annotations for IRSA
- Helm chart version management
- Ingress configuration for HTTP routing

**Module Location**: `./helm/modules/helm-chart/`

**Dependencies**: Reads cluster state from remote state

---

## 🚀 Deployment Steps

Follow these steps in order to deploy the complete infrastructure:

### **Step 1: Deploy Backend Storage**

```bash
cd backend-s3
terraform init
terraform plan
terraform apply
```

**What it does**: Creates S3 buckets and DynamoDB table for state management.

**Manual Input Required**: None (first deployment)

**Outputs**:

- S3 bucket names
- DynamoDB table name

---

### **Step 2: Deploy VPC**

```bash
cd ../vpc
terraform init
terraform plan
terraform apply
```

**What it does**: Creates VPC, subnets, NAT Gateway, and all networking components.

**Manual Input Required**:

**All manual changes already applied**

- Update `backend.tf` with your S3 bucket name and region from Step 1
- Update `variable.auto.tfvars` with desired configuration

**Backend Configuration** (`backend.tf`):

```hcl
terraform {
  backend "s3" {
    bucket         = "YOUR-BUCKET-NAME"      # From backend-s3 output
    region         = "YOUR-REGION"           # e.g., eu-north-1
    key            = "vpc/terraform.tfstate"
    dynamodb_table = "YOUR-DYNAMODB-TABLE"   # From backend-s3 output
    profile        = "YOUR-AWS-PROFILE"      # Your AWS CLI profile
  }
}
```

**Outputs**:

- VPC ID
- Public/private subnet IDs
- NAT Gateway ID

---

### **Step 3: Deploy EKS Cluster**

```bash
cd ../cluster
terraform init
terraform plan
terraform apply
```

**What it does**: Creates EKS cluster, Fargate profiles, and IAM roles.

**Manual Input Required**:

- Update `backend.tf` with your S3 backend configuration
- Update `variable.auto.tfvars` with:
  - VPC state bucket name
  - VPC state key (`vpc/terraform.tfstate`)
  - Cluster name and version

**Backend Configuration** (`backend.tf`):

```hcl
terraform {
  backend "s3" {
    bucket         = "YOUR-BUCKET-NAME"
    region         = "YOUR-REGION"
    key            = "cluster/terraform.tfstate"
    dynamodb_table = "YOUR-DYNAMODB-TABLE"
    profile        = "YOUR-AWS-PROFILE"
  }
}
```

**Data Source Configuration** (`data.tf`):

```hcl
# Reads VPC outputs from remote state
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket  = "YOUR-BUCKET-NAME"           # Same as backend
    key     = "vpc/terraform.tfstate"      # VPC state key
    region  = "YOUR-REGION"
    profile = "YOUR-AWS-PROFILE"
  }
}
```

**Outputs**:

- EKS cluster ID
- EKS cluster endpoint
- AWS Load Balancer Controller IAM role ARN

---

### **Step 4: Deploy Helm Charts**

```bash
cd ../helm
terraform init
terraform plan
terraform apply
```

**What it does**: Deploys AWS Load Balancer Controller and sample application.

**Manual Input Required**:

- Update `backend.tf` with your S3 backend configuration
- Update `variable.auto.tfvars` with:
  - Cluster state bucket name
  - Cluster state key (`cluster/terraform.tfstate`)

**Backend Configuration** (`backend.tf`):

```hcl
terraform {
  backend "s3" {
    bucket         = "YOUR-BUCKET-NAME"
    region         = "YOUR-REGION"
    key            = "helm/terraform.tfstate"
    dynamodb_table = "YOUR-DYNAMODB-TABLE"
    profile        = "YOUR-AWS-PROFILE"
  }
}
```

**Data Source Configuration** (`main.tf`):

```hcl
# Reads cluster outputs from remote state
data "terraform_remote_state" "cluster" {
  backend = "s3"
  config = {
    bucket  = "YOUR-BUCKET-NAME"
    key     = "cluster/terraform.tfstate"
    region  = "YOUR-REGION"
    profile = "YOUR-AWS-PROFILE"
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
