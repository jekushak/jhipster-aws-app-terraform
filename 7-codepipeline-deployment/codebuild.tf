# ---------------------------------------------------------------------------------------------------------------------
# CodeBuild
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_codebuild_project" "codebuild" {
  name          = local.aws_codebuild_name
  description   = "code build for ${local.app_service} branch ${local.branch-name}"
  build_timeout = local.build-timeout
  service_role  = aws_iam_role.codebuild_role.arn
  tags = merge(
    local.common_tags,
    {
      Name    = local.aws_codebuild_name
      AppRole = "Developer Tools"
    }
  )
  artifacts {
    type = "CODEPIPELINE" #"NO_ARTIFACTS"
  }
  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec-docker.yml"
  }
  #  source {
  #    type      = var.sourcecode["type"]
  #    location  = var.sourcecode["location"]
  #    buildspec = var.sourcecode["buildspec"]
  #  }
  environment {
    compute_type    = local.compute_type
    image           = local.image
    type            = local.type
    privileged_mode = local.privileged_mode

    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = local.region
    }
    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = data.aws_caller_identity.current.account_id
    }
    environment_variable {
      name  = "IMAGE_REPO_URL"
      value = data.aws_ecr_repository.ecr-repo.repository_url
    }
    environment_variable {
      name  = "IMAGE_TAG"
      value = "latest"
    }

    environment_variable {
      name  = "APP_NAME"
      value = local.app_service
    }
    environment_variable {
      name  = "BRANCH_NAME"
      value = local.branch-name
    }
    environment_variable {
      name  = "SERVICE_PORT"
      value = var.container_port
    }
    environment_variable {
      name  = "TERRAFORM_VERSION"
      value = "0.13.0"
    }
  }
}



