# ---------------------------------------------------------------------------------------------------------------------
# VPC
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_vpc" "main" {
  cidr_block                       = var.vpc_cidr_block
  instance_tenancy                 = var.vpc_instance_tenancy
  assign_generated_ipv6_cidr_block = var.assign_ipv6_cidr_block
  enable_dns_hostnames             = var.enable_dns_hostnames
  tags = merge(
    local.common_tags,
    {
      Name    = local.aws_vpc_name
      AppRole = "Networking & Content Delivery"
    }
  )
}
# ---------------------------------------------------------------------------------------------------------------------
# VPC Flow Logs
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_flow_log" "vpc_flog_logs" {
  iam_role_arn    = aws_iam_role.vpc-flow-logs-role.arn
  log_destination = aws_cloudwatch_log_group.vpc_cw.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.main.id
  tags = merge(
    local.common_tags,
    {
      Name    = local.aws_vpc_flow_logs
      AppRole = "Networking & Content Delivery"
    }
  )
}

resource "aws_cloudwatch_log_group" "vpc_cw" {
  name = "${local.aws_vpc_flow_logs}-cloudwatch-log-group"
}

