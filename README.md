### Overview:

This Terraform project demonstrates how to use Infrastructure as Code (IaC) to provision a basic AWS infrastructure. It creates a VPC with public and private subnets, an internet gateway, NAT gateway, security groups, EC2 instances, and an application load balancer (ALB).

### Prerequisites:

- AWS account
- Terraform installed

### Steps:

1. Clone this repository to your local machine.
2. Navigate to the project directory.
3. Modify the `vars.tf` file to customize the AWS region, VPC CIDR range, subnet availability zones, instance type, and AMI.
4. Comment the backend part in "terraform.tf"
5. Run `terraform init` to initialize the Terraform configuration.
6. Run `terraform plan` to preview the changes that will be made.
7. Run `terraform apply` to apply the changes and create the AWS resources.
8. Run `terraform init` to initialize the backend with the S3 bucket.
9. (Optional) Run `terraform destroy` to destroy the AWS resources created by this project.

### Note:

- Ensure your AWS credentials are properly configured and secure.
- Review and customize the Terraform scripts according to your requirements before applying them to your AWS account.
- NAT gateway is not free tier eligiable
