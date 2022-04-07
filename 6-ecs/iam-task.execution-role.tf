resource "aws_iam_role" "ecs-task-execution-role" {
  name               = local.aws_role_for_task_execution
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "ecsTaskExecutionRole",
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "ecs-tasks.amazonaws.com"
                ]
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
  tags = merge(
    local.common_tags,
    {
      Name    = local.aws_role_for_task_execution
      AppRole = "Security Identity  Compliance"
    }
  )
}

#ECS Task Role
resource "aws_iam_role" "ecs_task_role" {
  name = local.aws_role_for_task

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["ecs.amazonaws.com","ecs-tasks.amazonaws.com"]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "ssm" {
  name        = "${local.aws_role_for_task_execution}-ssm"
  description = "Policy that allows access to SSM"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ssm:*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}
resource "aws_iam_policy" "ecs-task-execute-policy" {
  name        = local.aws_policy_for_task_execute
  description = "AmazonECSTaskExecutionRolePolicy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
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
      Name    = local.aws_policy_for_task_execute
      AppRole = "Security Identity  Compliance"
    }
  )
}

resource "aws_iam_role_policy_attachment" "task-execute-policy" {
  role       = aws_iam_role.ecs-task-execution-role.name
  policy_arn = aws_iam_policy.ecs-task-execute-policy.arn
}


resource "aws_iam_role_policy_attachment" "ecs-task-role-policy" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.ssm.arn
}

resource "aws_iam_role_policy_attachment" "ecs-task-role-policy-attachment-for-ssm" {
  role       = aws_iam_role.ecs-task-execution-role.name
  policy_arn = aws_iam_policy.ssm.arn
}



