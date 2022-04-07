# ---------------------------------------------------------------------------------------------------------------------
# FARGATE TASK DEFINITION
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_ecs_task_definition" "fargate-task" {
  family                   = var.family
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  execution_role_arn       = aws_iam_role.ecs-task-execution-role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  container_definitions = jsonencode([{
    name        = var.family
    image       = "${data.aws_ecr_repository.ecr-repo.repository_url}:latest"
    essential   = true
    environment = "container"
    portMappings = [{
      protocol      = "tcp"
      containerPort = var.container_port
      hostPort      = var.container_port
      }
    ]
    environment = [
      {
        "name" : "DATABASE",
        "value" : local.environment
      },
      {
        "name" : "DATABASE_URL",
        "value" : "jdbc:postgresql://xxxxx"
      },
      {
        "name" : "SPRING_DATASOURCE_USERNAME",
        "value" : "$DB_USERNAME"
      },
      {
        "name" : "SPRING_DATASOURCE_PASSWORD",
        "value" : "$DB_PASSWORD"
      },
      {
        "name" : "SPRING_PROFILES_ACTIVE",
        "value" : "prod,swagger"
      },
      {
        "name" : "JAVA_OPTS",
        "value" : "-Djava.net.preferIPv4Stack=true -Djava.net.preferIPv4Addresses"
      },
      {
        "name" : "JHIPSTER_SLEEP",
        "value" : "0"
      },
    ]
    logConfiguration = {
      logDriver = "awslogs"
      "secretOptions" : [],
      options = {
        awslogs-group         = aws_cloudwatch_log_group.cloudwatchlogs.name
        awslogs-stream-prefix = "ecs"
        awslogs-region        = local.region
      }
    }
  }])

  tags = merge(
    local.common_tags,
    {
      Name    = "${local.aws_ecs_cluster_name}-task"
      AppRole = "Containers"
    }
  )
}
