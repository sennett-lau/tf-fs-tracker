# Terraform Foundation Tracker for AWS

## Description

This is a Terraform module that creates a foundation for AWS. It creates resources like VPC, Subnets, Route Tables, Internet Gateway, NAT Gateway, etc.

## Implementation

### Prerequisites
1. A s3 bucket to store the Terraform state file.
2. A DynamoDB table to store the Terraform state lock.
3. A Keypair to access the EC2 instances for bastion host (optional).

### Usage
1. Update the `generic-variables.tf` file's `aws_region` and `env` variables.
2. Update the s3 bucket name in `provider.tf` file.
3. Update the DynamoDB table name in `provider.tf` file.
4. Update the `bastion_key_name` variable in `bastion.auto.tfvars` file.
5. Update any other variables in `*.auto.tfvars` file for the desired inputs.
6. Run `terraform init` to initialize the Terraform.
7. Run `terraform plan` to see the changes that will be applied.
8. Run `terraform apply` to apply the changes.

### Variables

#### Generic Variables
1. `aws_region` - The AWS region to deploy the resources.
2. `env` - default as `dev`, can also be string like `prod`, `uat` etc..
3. `project` - default as `fs` meaning foundation.
4. `module` - default as `tracker`.

#### More Variables
1. `az_count` - default as `6`, can be any number between `1` and the number of availability zones in the region.

#### VPC Module
1. `vpc_cidr` - CIDR block for the VPC.
2. `subnet_cidr` - CIDR block for the subnets.
```
type = map(list(string))

# should provide a list of CIDR blocks for both public and private subnets
{
    public_subnets = [...],
    private_subnets = [...]
}
```

#### Bastion Module

#### SNS Module

### Outputs

## Resources

