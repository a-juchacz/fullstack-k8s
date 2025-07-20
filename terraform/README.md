# Terraform Configuration

This directory contains Terraform configurations for managing AWS, Kubernetes, and Helm resources.

## Files

- `providers.tf` - Main provider configuration for AWS, Kubernetes, and Helm
- `main.tf` - VPC and EKS cluster configuration using terraform-aws-modules (cost-optimized)
- `main-minimal.tf` - Ultra-minimal configuration for maximum cost savings (single AZ, no NAT Gateway)
- `variables.tf` - Variable definitions used across the configuration
- `outputs.tf` - Output values for VPC and EKS cluster information
- `terraform.tfvars.example` - Example variable values (copy to `terraform.tfvars` and customize)

## Setup

1. **Copy the example variables file:**
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. **Edit `terraform.tfvars` with your specific values:**
   - Set your AWS region
   - Configure your Kubernetes cluster context
   - Update project name and environment as needed

3. **Initialize Terraform:**
   ```bash
   terraform init
   ```

4. **Plan your changes:**
   ```bash
   terraform plan
   ```

5. **Apply the configuration:**
   ```bash
   terraform apply
   ```

## Prerequisites

- Terraform >= 1.0
- AWS CLI configured with appropriate credentials
- kubectl configured with access to your Kubernetes cluster
- Helm (if using Helm resources)

## Provider Versions

- AWS Provider: ~> 5.0
- Kubernetes Provider: ~> 2.0
- Helm Provider: ~> 2.0

## Module Versions

- VPC Module: ~> 5.0
- EKS Module: ~> 19.0

## Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `aws_region` | AWS region to deploy resources | `us-west-2` |
| `project_name` | Name of the project | `fullstack-k8s` |
| `environment` | Environment name | `dev` |
| `vpc_cidr` | CIDR block for VPC | `10.0.0.0/16` |
| `availability_zones` | Availability zones for the VPC | `["us-west-2a", "us-west-2b", "us-west-2c"]` |
| `public_subnet_cidrs` | CIDR blocks for public subnets | `["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]` |
| `private_subnet_cidrs` | CIDR blocks for private subnets | `["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]` |
| `cluster_name` | Name of the EKS cluster | `fullstack-k8s-cluster` |
| `instance_type` | EC2 instance type for worker nodes | `t3.small` |
| `desired_node_count` | Desired number of worker nodes | `2` |
| `min_node_count` | Minimum number of worker nodes | `1` |
| `max_node_count` | Maximum number of worker nodes | `4` |
| `kubernetes_version` | Kubernetes version for EKS | `1.28` |
| `kubeconfig_path` | Path to kubeconfig file | `~/.kube/config` |
| `kubeconfig_context` | Kubernetes context to use | `null` |

## Cost Optimization

### Current Configuration (`main.tf`)
- **2 Availability Zones** (reduced from 3)
- **Single NAT Gateway** (saves ~$45/month)
- **Spot Instances** (saves ~60-70% on compute)
- **20GB disk** (reduced from 50GB)
- **2 nodes minimum** with autoscaling

### Ultra-Minimal Configuration (`main-minimal.tf`)
- **Single Availability Zone** (maximum cost savings)
- **No NAT Gateway** (saves ~$45/month, but nodes can't access internet)
- **Single node** (minimum viable cluster)
- **Spot instances only**
- **Limited scaling** (1-2 nodes)

### Estimated Monthly Costs (us-west-2)
| Configuration | EKS Control Plane | Worker Nodes | NAT Gateway | Total |
|---------------|-------------------|--------------|-------------|-------|
| Current (2 AZ) | $73.00 | ~$30-60 | $45.00 | ~$148-178 |
| Minimal (1 AZ) | $73.00 | ~$15-30 | $0.00 | ~$88-103 |

## Notes

- The AWS provider includes default tags for all resources
- Kubernetes and Helm providers use the same kubeconfig configuration
- Make sure your AWS credentials are properly configured before running Terraform
- The VPC is configured with both public and private subnets across 2 availability zones
- EKS cluster is deployed in private subnets with public endpoint access
- NAT Gateway is configured for private subnet internet access (single gateway for cost optimization)
- Worker nodes are configured with proper security groups and autoscaling
- Spot instances may be interrupted - suitable for dev/test workloads 