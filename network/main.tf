module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name               = "${var.stage}-vpc"
  cidr               = "10.0.0.0/16"
  azs                = ["${var.region}a", "${var.region}b"]
  # private_subnets    = ["10.0.1.0/24", "10.0.2.0/24"]     # 2 for High-Availability
  public_subnets     = ["10.0.101.0/24", "10.0.102.0/24"] # 2 for High-Availability
  # enable_nat_gateway = true

  tags = {
    Terraform = "true"
    Stage     = var.stage
    Account   = data.aws_caller_identity.current.account_id
    App-name  = var.app-name
  }
}

module "vpc_endpoints" {
  source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"

  vpc_id = module.vpc.vpc_id

  create_security_group      = true
  security_group_name_prefix = "${var.stage}-vpc-endpoints"
  security_group_description = "VPC endpoint security group"
  security_group_rules = {
    ingress_https = {
      description = "HTTPS from VPC"
      cidr_blocks = [module.vpc.vpc_cidr_block]
    }
  }

  endpoints = {
    ssm = {
      service             = "ssm"
      subnet_ids          = module.vpc.private_subnets
      private_dns_enabled = true
      dns_options = {
        private_dns_only_for_inbound_resolver_endpoint = false
      }
      tags = { Name = "ssm-vpc-endpoint" }
    },
    ec2messages = {
      service             = "ec2messages"
      subnet_ids          = module.vpc.private_subnets
      private_dns_enabled = true
      dns_options = {
        private_dns_only_for_inbound_resolver_endpoint = false
      }
      tags = { Name = "ec2messages-vpc-endpoint" }
    },
    ec2 = {
      service             = "ec2"
      subnet_ids          = module.vpc.private_subnets
      private_dns_enabled = true
      dns_options = {
        private_dns_only_for_inbound_resolver_endpoint = false
      }
      tags = { Name = "ec2-vpc-endpoint" }
    },
    ssmmessages = {
      service             = "ssmmessages"
      subnet_ids          = module.vpc.private_subnets
      private_dns_enabled = true
      dns_options = {
        private_dns_only_for_inbound_resolver_endpoint = false
      }
      tags = { Name = "ssmmessages-vpc-endpoint" }
    }
  }
}
