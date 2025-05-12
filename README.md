# AWS VPC with EKS - Terraform Modular Infrastructure

This Terraform project creates AWS infrastructure with a modular approach, consisting of a centralized root configuration that manages VPC and EKS modules.

## Project Structure

```
.
├── main.tf                 # Root configuration file
├── variables.tf            # Root variables
├── outputs.tf              # Root outputs
├── terraform.tfvars        # Variable values
├── update-kubeconfig.sh    # Helper script
├── modules/
│   ├── vpc/                # VPC module
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── eks/                # EKS module
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── README.md
```

## Architecture

The infrastructure includes:

- **VPC Module**:

  - VPC with custom CIDR block
  - Public and private subnets across multiple availability zones
  - Internet Gateway and NAT Gateway
  - Route tables and security groups
  - VPC Flow Logs

- **EKS Module**:
  - Amazon EKS cluster
  - Managed node group
  - IAM roles and policies
  - Security groups

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0.0
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate credentials
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) for Kubernetes management

## How It Works

The root `main.tf` file serves as the central configuration that:

1. Defines the AWS provider configuration
2. Creates the VPC module instance with appropriate parameters
3. Creates the EKS module instance with parameters including VPC details
4. Uses module outputs to expose important information

The connection between VPC and EKS is established by passing the VPC module outputs (like VPC ID and subnet IDs) to the EKS module inputs. This ensures that EKS is correctly deployed within the VPC.

## Usage

1. Clone this repository
2. Update the `terraform.tfvars` file with your settings
3. Initialize the Terraform working directory:

```bash
terraform init
```

4. Review the execution plan:

```bash
terraform plan
```

5. Apply the changes:

```bash
terraform apply
```

6. Configure kubectl to connect to your EKS cluster:

```bash
chmod +x update-kubeconfig.sh
./update-kubeconfig.sh
```

7. Verify connectivity:

```bash
kubectl get nodes
```

8. To destroy the infrastructure:

```bash
terraform destroy
```

## Customization

Modify the following variables in `terraform.tfvars` to customize your deployment:

### VPC Configuration

- `region` - AWS region for deployment
- `environment` - Environment name (dev, staging, prod)
- `vpc_cidr` - CIDR block for the VPC
- `availability_zones` - List of AZs to use
- `public_subnet_cidrs` - CIDR blocks for public subnets
- `private_subnet_cidrs` - CIDR blocks for private subnets

### EKS Configuration

- `kubernetes_version` - Kubernetes version for the EKS cluster
- `eks_node_instance_types` - EC2 instance types for worker nodes
- `eks_node_desired_size` - Desired number of worker nodes
- `eks_node_max_size` - Maximum number of worker nodes
- `eks_node_min_size` - Minimum number of worker nodes

## Best Practices Implemented

- **Modular Design**: Infrastructure split into logical modules
- **Single Source of Truth**: Root configuration manages all modules
- **Explicit Dependencies**: Clear dependency chain from VPC to EKS
- **High Availability**: Resources deployed across multiple AZs
- **Security**: Private subnets for EKS nodes, VPC Flow Logs enabled
- **Naming Convention**: Consistent naming with environment prefixes
- **Documentation**: Comprehensive README and code comments
- **Tags**: All resources tagged for better management

## Notes

- The NAT Gateway is deployed in only one AZ to reduce costs. For production workloads requiring higher availability, consider deploying a NAT Gateway in each AZ.
- For production use, consider adding additional EKS add-ons such as cluster autoscaler, AWS Load Balancer Controller, etc.
