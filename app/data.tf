data "aws_caller_identity" "current" {}
# runs aws sts get-caller-identity --profile {NAME}

data "aws_vpc" "dev" {
  tags = {
    Terraform = "true"
    Stage     = var.stage
    Account   = data.aws_caller_identity.current.account_id
  }
}

data "aws_subnet" "private" {
  vpc_id = data.aws_vpc.dev.id
  filter {
    name   = "tag:Name"
    values = ["dev-vpc-private-eu-west-2a"]
  }
}

data "aws_subnet" "public" {
  vpc_id = data.aws_vpc.dev.id
  filter {
    name   = "tag:Name"
    values = ["dev-vpc-public-eu-west-2a"]
  }
}

data "aws_secretsmanager_secret" "remote_ip" {
  name = "remote-access-ip"
}

data "aws_secretsmanager_secret_version" "current" {
  secret_id = data.aws_secretsmanager_secret.remote_ip.id
}

data "aws_security_group" "vpc-endpoints-sg" {
  name = "${var.stage}-vpc-endpoints*"
}