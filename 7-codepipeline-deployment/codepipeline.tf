# ---------------------------------------------------------------------------------------------------------------------
# CodePipeline
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_codepipeline" "code-pipeline" {
  name     = local.aws_codepipeline_name
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = var.bucketname
    type     = var.artifact_type
  }
  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["SourceArtifact"]

      configuration = {
        RepositoryName = data.aws_codecommit_repository.codecommit-repo.repository_name
        BranchName     = local.branch-name
      }
    }
  }
  stage {
    name = "Plan"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["BuildArtifact"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.codebuild.name
      }
    }
  }
  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeployToECS"
      input_artifacts = ["BuildArtifact"]
      version         = "1"

      configuration = {
        ApplicationName                = aws_codedeploy_app.codedeploy.name
        DeploymentGroupName            = aws_codedeploy_deployment_group.deploy-group.deployment_group_name
        TaskDefinitionTemplateArtifact = "BuildArtifact"
        TaskDefinitionTemplatePath     = "taskdef.json"
        AppSpecTemplateArtifact        = "BuildArtifact"
        AppSpecTemplatePath            = "appspec.yml"
      }
    }
  }
  #  stage {
  #    name = "Deploy"
  #
  #    action {
  #      name            = "Deploy"
  #      category        = "Deploy"
  #      owner           = "AWS"
  #      provider        = "CodeDeployToECS"
  #      input_artifacts = ["BuildArtifact"]
  #      version         = "1"
  #
  #      configuration = {
  #        ClusterName = var.ecs_cluster_name
  #        ServiceName = var.ecs_service_name
  #      }
  #    }
  #  }

  stage {
    name = "Manual_Approval"

    action {
      name     = "Manual-Approval"
      category = "Approval"
      owner    = "AWS"
      provider = "Manual"
      version  = "1"
    }
  }
}

