locals {
  app_service              = "tennis"
  environment              = "dev"
  cost_centre              = "devOps"
  project                  = "slp"
  owner                    = "zhenishgul"
  region                   = "eu-north-1"
  username                 = "XXXX"
  password                 = "XXXX"
  engine                   = "postgres"
  engine_version           = "13.4"
  aws_rds_name             = "tennis-${local.environment}-rds-${local.app_service}"
  aws_rds_username         = "user-${local.environment}-rds-${local.app_service}"
  aws_db_subnetsgroup      = "aws_db_subnetsgroup-${local.environment}-rds-${local.app_service}"
  aws_rds_security_gr_name = "securitygr-${local.environment}-rds-${local.app_service}"
  common_tags = {
    environment = local.environment
    project     = local.project
    cost_centre = local.cost_centre
    owner       = local.owner
  }
}
#data "aws_security_group" "alb-sg" {
#  id = var.security_group_id
#}
