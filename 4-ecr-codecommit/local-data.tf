locals {
  app_service         = "tennis"
  environment         = "dev"
  cost_centre         = "devops"
  project             = "slp"
  owner               = "zhenishgul"
  aws_ecr_name        = "ecr-${local.app_service}-${local.environment}-${local.project}"
  aws_codecommit_name = "codecommit-${local.app_service}-${local.environment}-${local.project}"
  common_tags = {
    project     = local.project
    cost_centre = local.cost_centre
    owner       = local.owner
  }
}

