locals {
  app_service              = "tennis"
  environment              = "dev"
  cost_centre              = "devops"
  project                  = "slp"
  owner                    = "zhenishgul"
  aws_alb_name             = "alb-${local.app_service}-${local.environment}-${local.project}"
  aws_target_group_name    = "target-gr-${local.app_service}-${local.environment}-${local.project}"
  aws_alb_security_gr_name = "alb-${local.app_service}-${local.environment}-securitygroup-${local.project}"
  common_tags = {
    project     = local.project
    cost_centre = local.cost_centre
    owner       = local.owner
  }
}
data "aws_vpc" "vpc" {
  id = var.vpc_id
}

