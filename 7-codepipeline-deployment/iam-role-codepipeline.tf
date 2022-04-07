resource "aws_iam_role" "codepipeline_role" {
  name = local.aws_role_for_codepipeline

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
data "aws_iam_policy_document" "codepipeline_policy" {
  statement {
    sid = "ALlowCodeCommit"
    actions = [
      "codecommit:CancelUploadArchive",
      "codecommit:GetBranch",
      "codecommit:GetCommit",
      "codecommit:GetUploadArchiveStatus",
      "codecommit:UploadArchive",
      "codecommit:GetBranch"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "AllowS3"
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObject",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "AllowECR"
    effect = "Allow"

    actions   = ["ecr:DescribeImages"]
    resources = ["*"]
  }

  statement {
    sid    = "AllowCodebuild"
    effect = "Allow"

    actions = [
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowCodedepoloy"
    effect = "Allow"

    actions = [
      "codedeploy:CreateDeployment",
      "codedeploy:GetApplication",
      "codedeploy:GetApplicationRevision",
      "codedeploy:GetDeployment",
      "codedeploy:GetDeploymentConfig",
      "codedeploy:RegisterApplicationRevision"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowResources"
    effect = "Allow"

    actions = [
      "ec2:*",
      "elasticloadbalancing:*",
      "autoscaling:*",
      "cloudwatch:*",
      "rds:*",
      "ecs:*",
      "iam:PassRole"
    ]
    resources = ["*"]
  }
}
resource "aws_iam_policy" "ci-codepipeline_policy" {
  name        = local.aws_policy_for_codepipeline
  description = "Pipeline policy"
  policy      = data.aws_iam_policy_document.codepipeline_policy.json
}
resource "aws_iam_role_policy_attachment" "ci-pipeline-attachment" {
  policy_arn = aws_iam_policy.ci-codepipeline_policy.arn
  role       = aws_iam_role.codepipeline_role.id
}
#resource "aws_iam_role_policy_attachment" "codepipeline_codecommit" {
#  role       = aws_iam_role.codepipeline_role.name
#  policy_arn = "arn:aws:iam::aws:policy/AWSCodeCommitFullAccess"
#}




