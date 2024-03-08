# Terraform AWS Infrastructure as Code (IaC) Project

This Terraform project demonstrates how to use Infrastructure as Code (IaC) to provision a basic AWS infrastructure. It creates a VPC with public and private subnets, an internet gateway, NAT gateway, security groups, EC2 instances, and an application load balancer (ALB).

## Prerequisites

- [AWS account](https://aws.amazon.com/)
- [Terraform installed](https://learn.hashicorp.com/tutorials/terraform/install-cli)

## Deployment

1. **Clone this repository to your local machine:**

   ```sh
   git clone <repository-url>
   cd <repository-directory>

   ```

2. **Modify the `vars.tf` file:**

- Customize the AWS region, VPC CIDR range, subnet availability zones, instance type, and AMI according to your requirements.

3. **Comment out the backend configuration in `terraform.tf`**

- To disable the backend configuration, comment out the relevant section in the `terraform.tf` file.

4. **Initialize the Terraform configuration:**

```sh
terraform init
```

5. **Preview the changes:**

```sh
terraform plan
```

6. **Apply the changes and create the AWS resources:**

```sh
terraform apply
```

7. **Initialize the Backend:**

```sh
terraform init
```

## Notes:

- Ensure your AWS credentials are properly configured and secure.
- Review and customize the Terraform scripts according to your requirements before applying them to your AWS account.
- NAT gateway is not free tier eligiable

