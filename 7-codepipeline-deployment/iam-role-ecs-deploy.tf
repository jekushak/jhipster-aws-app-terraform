resource "aws_iam_role" "role-for-ecs-codedeploy" {
  name               = local.aws_role_for_ecs_codedeploy
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "ecsCodeDeployRole",
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "codedeploy.amazonaws.com"
                ]
            },
            "Action": [
                "sts:AssumeRole"
            ]
        }
    ]
}
EOF
  tags = merge(
    local.common_tags,
    {
      Name    = local.aws_role_for_ecs_codedeploy
      AppRole = "Security Identity  Compliance"
    }
  )
}
resource "aws_iam_role" "task_execution_role" {
  name               = "${local.aws_role_for_ecs_codedeploy}-task"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "ecsCodeDeployRole",
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "ecs-tasks.amazonaws.com"
                ]
            },
            "Action": [
                "sts:AssumeRole"
            ]
        }
    ]
}
EOF
  tags = merge(
    local.common_tags,
    {
      Name    = "${local.aws_role_for_ecs_codedeploy}-task"
      AppRole = "Security Identity  Compliance"
    }
  )
}
resource "aws_iam_role_policy_attachment" "task_execution_policy_attach" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  role       = aws_iam_role.task_execution_role.name
}


resource "aws_iam_policy" "ecs-codedeploy-policy" {
  name        = local.aws_policy_for_ecs_codedeploy
  path        = "/"
  description = "AmazonEC2ContainerServiceforEC2Role "

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:DescribeInstances",
        "ec2:DescribeInstanceStatus",
        "ec2:TerminateInstances",
        "tag:GetResources",
        "sns:Publish",
        "cloudwatch:DescribeAlarms",
        "cloudwatch:PutMetricAlarm",
        "elasticloadbalancing:DescribeLoadBalancers",
        "elasticloadbalancing:DescribeInstanceHealth",
        "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
        "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
        "elasticloadbalancing:DescribeTargetGroups",
        "elasticloadbalancing:DescribeTargetHealth",
        "elasticloadbalancing:RegisterTargets",
        "elasticloadbalancing:DeregisterTargets",
        "elasticloadbalancing:DescribeListeners",
        "elasticloadbalancing:DescribeRules",
        "elasticloadbalancing:ModifyListener",
        "elasticloadbalancing:ModifyRule",
        "ecs:CreateTaskSet",
        "ecs:DeleteTaskSet",
        "ecs:DescribeServices",
        "ecs:UpdateServicePrimaryTaskSet",
        "s3:GetObject"
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
      Name    = local.aws_policy_for_ecs_codedeploy
      AppRole = "Security Identity  Compliance"
    }
  )
}

resource "aws_iam_role_policy_attachment" "ecs-codedeploy" {
  role       = aws_iam_role.role-for-ecs-codedeploy.name
  policy_arn = aws_iam_policy.ecs-codedeploy-policy.arn
}

resource "aws_iam_role_policy_attachment" "ecs-codedeploy-role-for-ecs" {
  role       = aws_iam_role.role-for-ecs-codedeploy.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployRoleForECS"
}


#     "autoscaling:CompleteLifecycleAction",
#        "autoscaling:DeleteLifecycleHook",
#        "autoscaling:DescribeAutoScalingGroups",
#        "autoscaling:DescribeLifecycleHooks",
#        "autoscaling:PutLifecycleHook",
#        "autoscaling:RecordLifecycleActionHeartbeat",
#        "autoscaling:CreateAutoScalingGroup",
#        "autoscaling:UpdateAutoScalingGroup",
#        "autoscaling:EnableMetricsCollection",
#        "autoscaling:DescribePolicies",
#        "autoscaling:DescribeScheduledActions",
#        "autoscaling:DescribeNotificationConfigurations",
#        "autoscaling:SuspendProcesses",
#        "autoscaling:ResumeProcesses",
#        "autoscaling:AttachLoadBalancers",
#        "autoscaling:AttachLoadBalancerTargetGroups",
#        "autoscaling:PutScalingPolicy",
#        "autoscaling:PutScheduledUpdateGroupAction",
#        "autoscaling:PutNotificationConfiguration",
#        "autoscaling:PutWarmPool",
#        "autoscaling:DescribeScalingActivities",
#        "autoscaling:DeleteAutoScalingGroup",
