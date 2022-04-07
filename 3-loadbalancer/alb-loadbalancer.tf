# ---------------------------------------------------------------------------------------------------------------------
# Loadbalancer
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_alb" "tennis-alb" {
  name                       = local.aws_alb_name
  internal                   = var.internal
  load_balancer_type         = var.load_balancer_type
  security_groups            = [aws_security_group.alb_sg.id]
  subnets                    = var.public_subnets_cidr_blocks
  enable_deletion_protection = var.enable_deletion_protection
  tags = merge(
    local.common_tags,
    {
      Name    = local.aws_alb_name
      AppRole = "Compute"
    }
  )
}
## Listener
resource "aws_alb_listener" "listener-1" {
  load_balancer_arn = aws_alb.tennis-alb.arn
  port              = var.http_tcp_listeners[0]
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.target_group-1.arn
  }
  tags = local.common_tags
}
resource "aws_alb_listener" "listener-2" {
  load_balancer_arn = aws_alb.tennis-alb.arn
  port              = var.http_tcp_listeners[1]
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.target_group-2.arn
  }
  tags = local.common_tags
}
## Target Croup
resource "aws_alb_target_group" "target_group-1" {
  name        = "${local.aws_target_group_name}-1"
  port        = var.http_tcp_listeners[0]
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = data.aws_vpc.vpc.id

  health_check {
    healthy_threshold   = "3"
    interval            = "300"
    protocol            = "HTTP"
    matcher             = "200-399"
    timeout             = "30"
    path                = "/alb_health/status"
    unhealthy_threshold = "2"
  }

  tags = local.common_tags
}
resource "aws_alb_target_group" "target_group-2" {
  name        = "${local.aws_target_group_name}-2"
  port        = var.http_tcp_listeners[1]
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = data.aws_vpc.vpc.id

  health_check {
    healthy_threshold   = "3"
    interval            = "300"
    protocol            = "HTTP"
    matcher             = "200-399"
    timeout             = "30"
    path                = "/alb_health/status"
    unhealthy_threshold = "2"
  }

  tags = local.common_tags
}
