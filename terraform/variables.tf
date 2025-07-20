# AWS Configuration Variables
variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-west-2"
}

# Project Configuration Variables
variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "fullstack-k8s"
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, production)"
  type        = string
  default     = "dev"
}

# VPC Configuration Variables
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Availability zones for the VPC"
  type        = list(string)
  default     = ["us-west-2a"]  # Single AZ for cost optimization
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24"]  # Single subnet
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.11.0/24"]  # Single subnet
}

# EKS Cluster Configuration Variables
variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "fullstack-k8s-cluster"
}

variable "instance_type" {
  description = "EC2 instance type for EKS worker nodes"
  type        = string
  default     = "t3.small"
}

variable "desired_node_count" {
  description = "Desired number of worker nodes in the EKS cluster"
  type        = number
  default     = 2
}

variable "min_node_count" {
  description = "Minimum number of worker nodes in the EKS cluster"
  type        = number
  default     = 1
}

variable "max_node_count" {
  description = "Maximum number of worker nodes in the EKS cluster"
  type        = number
  default     = 4
}

variable "kubernetes_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.28"
}

variable "use_spot_instances" {
  description = "Whether to use Spot instances for cost optimization"
  type        = bool
  default     = true
}

# Kubernetes Configuration Variables
variable "kubeconfig_path" {
  description = "Path to the kubeconfig file"
  type        = string
  default     = "~/.kube/config"
}

variable "kubeconfig_context" {
  description = "Kubernetes context to use"
  type        = string
  default     = null
} 