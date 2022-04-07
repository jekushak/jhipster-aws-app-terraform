locals {
  app_service              = "tennis"
  environment              = "dev"
  cost_centre              = "devops"
  project                  = "slp"
  owner                    = "zhenishgul"
  username                 = "XXXX"
  password                 = "XXXX"
  engine                   = "postgres"
  engine_version           = "13.4"
  aws_rds_db_identifier    = "rds-${local.app_service}-${local.environment}-${local.app_service}"
  aws_db_subnetsgroup      = "subnetsgroup-${local.app_service}-${local.environment}-rds-${local.app_service}"
  aws_db_parameter_gr      = "parametergr-${local.app_service}-${local.environment}-rds-${local.app_service}"
  aws_rds_security_gr_name = "securitygr-${local.app_service}-${local.environment}-rds-${local.app_service}"
  common_tags = {
    project     = local.project
    cost_centre = local.cost_centre
    owner       = local.owner
  }
}

data "aws_vpc" "vpc" {
  id = var.vpc_id
}
