locals {
  app_service             = "tennis"
  environment             = "dev"
  cost_centre             = "devops"
  project                 = "slp"
  owner                   = "zhenishgul"
  aws_vpc_name            = "VPC-${local.app_service}-${local.environment}-${local.project}"
  aws_vpc_flow_logs       = "VPC-${local.app_service}-${local.environment}-flow-logs-${local.project}"
  aws_public_subnet_name  = "subnet-${local.app_service}-${local.environment}-public-${local.project}"
  aws_private_subnet_name = "subnet-${local.app_service}-${local.environment}-private-${local.project}"
  common_tags = {
    project     = local.project
    cost_centre = local.cost_centre
    owner       = local.owner
  }
}


