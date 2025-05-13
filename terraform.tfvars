# VPC Configuration
region               = "us-east-1"
environment          = "dev"
vpc_cidr             = "10.0.0.0/16"
availability_zones   = ["us-east-1a", "us-east-1b", "us-east-1c"]
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
default_tags = {
  Project     = "terraform-vpc-eks"
  Environment = "dev"
  ManagedBy   = "terraform"
  Owner       = "Din"
}

# EKS Configuration
kubernetes_version      = "1.29"
eks_node_instance_types = ["t3.medium"]
eks_node_desired_size   = 2
eks_node_max_size       = 3
eks_node_min_size       = 1
