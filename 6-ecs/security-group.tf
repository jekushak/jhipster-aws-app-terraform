resource "aws_security_group" "ecs_sg" {
  name   = local.aws_ecs_security_gr_name
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["MyIP"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["MyIP"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["MyIP"]
  }
  tags = merge(
    local.common_tags,
    {
      Name    = local.aws_ecs_security_gr_name
      AppRole = "Compute"
    }
  )
}

