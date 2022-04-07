resource "aws_iam_role" "role-for-ecs-instance" {
  name               = local.aws_role_for_ecs_instance
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "ecsInstanceRole",
      "Effect": "Allow",
      "Principal": {
        "Service":"ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  tags = merge(
    local.common_tags,
    {
      Name    = local.aws_role_for_ecs_instance
      AppRole = "Security Identity  Compliance"
    }
  )
}

resource "aws_iam_policy" "ecs-instance-policy" {
  name        = local.aws_policy_for_ecs_instance
  path        = "/"
  description = "AmazonEC2ContainerServiceforEC2Role "

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:DescribeTags",
        "ecs:CreateCluster",
        "ecs:DeregisterContainerInstance",
        "ecs:DiscoverPollEndpoint",
        "ecs:Poll",
        "ecs:RegisterContainerInstance",
        "ecs:StartTelemetrySession",
        "ecs:UpdateContainerInstancesState",
        "ecs:Submit*",
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "*",
      "Effect": "Allow"
    }
  ]
}
EOF
  tags = merge(
    local.common_tags,
    {
      Name    = local.aws_policy_for_ecs_instance
      AppRole = "Security Identity  Compliance"
    }
  )
}
resource "aws_iam_role_policy_attachment" "ecs_instance" {
  role       = aws_iam_role.role-for-ecs-instance.name
  policy_arn = aws_iam_policy.ecs-instance-policy.arn
}
