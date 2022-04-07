locals {
  app_service                   = "tennis"
  environment                   = "development"
  cost_centre                   = "devops"
  project                       = "slp"
  owner                         = "zhenishgul"
  branch-name                   = "main"
  region                        = "eu-north-1"
  build-timeout                 = 60
  compute_type                  = "BUILD_GENERAL1_SMALL"
  image                         = "aws/codebuild/standard:5.0"
  type                          = "LINUX_CONTAINER"
  privileged_mode               = true
  aws_bucket_name               = "bucket-${local.app_service}-${local.environment}-${local.project}"
  aws_codepipeline_name         = "pipeline-${local.app_service}-${local.environment}-${local.project}"
  aws_codebuild_name            = "codebuild-${local.app_service}-${local.environment}-${local.project}"
  aws_codedeploy_name           = "codedeploy-${local.app_service}-${local.environment}-${local.project}"
  aws_codedeploy_group_name     = "codedeploy-${local.app_service}-${local.environment}-group-name-${local.project}"
  aws_role_for_codepipeline     = "iam-role-${local.app_service}-${local.environment}-codepipeline-${local.project}"
  aws_role_for_codebuild        = "iam-role-${local.app_service}-${local.environment}-codebuild-${local.project}"
  aws_role_for_ecs_codedeploy   = "iam-role-${local.app_service}-${local.environment}-codedeploy-${local.project}"
  aws_policy_for_codepipeline   = "iam-policy-${local.app_service}-${local.environment}-codepipeline${local.project}"
  aws_policy_for_codebuild      = "iam-policy-${local.app_service}-${local.environment}-codebuild${local.project}"
  aws_policy_for_ecs_codedeploy = "iam-policy-${local.app_service}-${local.environment}-codedeploy-${local.project}"
  common_tags = {
    environment = local.environment
    project     = local.project
    cost_centre = local.cost_centre
    owner       = local.owner
  }
}
data "aws_caller_identity" "current" {}
data "aws_ecr_repository" "ecr-repo" {
  name = ""
}
data "aws_codecommit_repository" "codecommit-repo" {
  repository_name = ""
}

