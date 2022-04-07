locals {
  app_service              = "tennis"
  environment              = "dev"
  cost_centre              = "devOps"
  project                  = "slp"
  owner                    = "zhenishgul"
  aws_ec2_name             = "ec2-${local.environment}-${local.project}"
  aws_ec2_security_gr_name = "ec2-${local.environment}-securitygroup-${local.project}"
  common_tags = {
    project     = local.project
    cost_centre = local.cost_centre
    owner       = local.owner
  }
}
data "aws_ssm_parameter" "ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}
data "aws_vpc" "vpc" {
  id = var.vpc_id
}
