# CI/CD on AWS: Terraform · Jenkins · Argo CD · EKS

Spin up a complete CI/CD infrastructure on AWS using Terraform, including networking, container registry, Kubernetes, Jenkins, Argo CD, and a configurable PostgreSQL database for a Django application.

---

## Overview

The infrastructure includes:

- Amazon VPC with public and private subnets
- Amazon ECR for Docker image storage
- Amazon EKS cluster
- Jenkins installed via Helm
- Argo CD installed via Helm
- Django application deployed with Helm
- Amazon RDS module supporting both:
  - Standard PostgreSQL RDS instance
  - Amazon Aurora PostgreSQL cluster

The RDS module is reusable and automatically creates the required database resources, including:

- DB Subnet Group
- Security Group
- Parameter Group

The database deployment type is controlled by the `use_aurora` variable.

```hcl
use_aurora = false   # Standard Amazon RDS PostgreSQL
# or
use_aurora = true    # Amazon Aurora PostgreSQL Cluster
```

---

## Prerequisites

- AWS account with configured CLI credentials (`aws configure` or `AWS_PROFILE`)
- Installed tools:
  - Terraform
  - AWS CLI
  - kubectl
  - Helm
  - Docker
  - Git
- GitHub Personal Access Token (PAT) with read/write access to `Maryna997/goit-devops-ci-cd`

> **Security:** Treat your GitHub Personal Access Token like a password. Never commit it to the repository.

---

## Quick Start

### 1) Select the database deployment type

Before deploying, choose which database Terraform should create.

```hcl
use_aurora = false   # Deploy a standard Amazon RDS instance
# or
use_aurora = true    # Deploy an Amazon Aurora cluster
```

### 2) Deploy everything

```shell
GITHUB_USERNAME=Maryna997 GITHUB_TOKEN=<YOUR_GITHUB_PAT> ./scripts/deploy.sh
```

Outputs will include the Jenkins and Argo CD URLs once the LoadBalancer services become available.

### 3) Show service URLs

```shell
sh ./scripts/show_urls.sh
```

Prints the endpoints for:

- Jenkins
- Argo CD
- Django application

### 4) Show admin credentials

```shell
sh ./scripts/show_passwords.sh
```

Credentials:

- Jenkins: `admin / <password provided via Terraform variable admin_password>`
- Argo CD: `admin / <printed password>`

### 5) Configure kubectl

```shell
sh ./scripts/aws_kubeconfig.sh
```

Updates your kubeconfig using the EKS cluster information from Terraform outputs.

You can then connect using:

- kubectl
- k9s
- Helm

### 6) Destroy everything

> **Warning:** Infrastructure destruction is not fully automated. Verify that all AWS resources have been removed after execution.

```shell
sh ./scripts/destroy.sh
```

The script removes:

- Helm releases
- Load Balancers
- Terraform-managed infrastructure

---

## Database Configuration

The project supports two PostgreSQL deployment options:

### Standard Amazon RDS

- Single PostgreSQL instance
- Optional Multi-AZ deployment
- Suitable for development and smaller workloads

### Amazon Aurora PostgreSQL

- Aurora cluster
- One writer instance
- Configurable number of reader instances
- Higher availability and scalability

The following parameters can be configured through Terraform variables:

- `use_aurora`
- `engine`
- `engine_version`
- `instance_class`
- `allocated_storage`
- `multi_az`
- `backup_retention_period`
- `parameters`

---

## Troubleshooting

- **URL is still `(pending)`**
  - Wait a few minutes for the AWS Load Balancer to finish provisioning.
  - Re-run:

    ```shell
    sh ./scripts/show_urls.sh
    ```

- **Argo CD repository error**
  - Verify your GitHub PAT.
  - Check the repository URL, branch, and chart path.

- **Jenkins pipeline was not created**
  - Wait one or two minutes after Jenkins starts.
  - Verify that the `github-token` credential exists.

- **Database deployment**
  - Ensure `use_aurora` is set correctly before running Terraform.
  - Verify that your selected engine version matches the chosen database type.
