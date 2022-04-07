locals {
  app_service         = "tennis"
  environment         = "dev"
  cost_centre         = "devOps"
  project             = "slp"
  owner               = "zhenishgul"
  region              = "eu-north-1"
  aws_db_subnetsgroup = "aws_db_subnetsgroup-${local.environment}-rds-${local.app_service}"
  common_tags = {
    environment = local.environment
    project     = local.project
    cost_centre = local.cost_centre
    owner       = local.owner
  }
}
