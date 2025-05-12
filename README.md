<p align="center">
  <img src="https://github.com/user-attachments/assets/cfea7eff-9ff8-4fbf-beea-cb753e758cc7" alt="Image 1" width="400"/>
  <img src="https://github.com/user-attachments/assets/dd8376a3-c96c-4ae4-b69b-3d56df81ccdc" alt="Image 2" width="400"/>
</p>

# AWS VPC with EKS - Terraform Modular Infrastructure

This Terraform project creates AWS infrastructure with a modular approach, consisting of a centralized root configuration that manages VPC and EKS modules.

## Project Structure

```
.
├── Jenkinsfile             # Jenkins pipeline for Terraform automation
├── main.tf                 # Root configuration file
├── variables.tf            # Root variables
├── outputs.tf              # Root outputs
├── terraform.tfvars        # Variable values
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

## How It Works

The root `main.tf` file serves as the central configuration that:

1. Defines the AWS provider configuration
2. Creates the VPC module instance with appropriate parameters
3. Creates the EKS module instance with parameters including VPC details
4. Uses module outputs to expose important information

The connection between VPC and EKS is established by passing the VPC module outputs (like VPC ID and subnet IDs) to the EKS module inputs. This ensures that EKS is correctly deployed within the VPC.

## CI/CD with Jenkins and Gitlab

This project includes automation for Terraform using a Jenkins pipeline (`Jenkinsfile`) and follows the **GitHub Flow** strategy:

1. **Feature Branch**:  
   Developers create a new branch for each infrastructure change, e.g., `feature/s3`.

2. **Push and Validate**:  
   When code is pushed to a feature branch, the Jenkins pipeline is triggered automatically to run:

   - `terraform init`
   - `terraform validate`
   - `terraform plan`

   This ensures early feedback and prevents errors before applying changes.

3. **Pull Request & Review**:  
   The developer opens a **Pull Request** (PR) to merge the feature branch into the main branch. The PR is reviewed by peers and must be approved before proceeding.

4. **Terraform Apply**:  
   Only after the PR is merged into the main branch, Jenkins triggers a final step:
   - `terraform apply`  
     This ensures that infrastructure changes are only applied to the live environment after review and approval.

This approach provides a **safe, auditable, and collaborative** method for managing infrastructure as code.
