locals {
  app_service            = "tennis"
  environment            = "a"
  cost_centre            = "devOps"
  project                = "slp"
  owner                  = "zhenishgul"
  aws_ec2_name           = "vpc-${local.environment}-${local.app_service}"
  aws_public_subnet_name = "subnet-${local.environment}-public-${local.app_service}"
  common_tags = {
    environment = local.environment
    project     = local.project
    cost_centre = local.cost_centre
    owner       = local.owner
  }
}

data "aws_ssm_parameter" "ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}
