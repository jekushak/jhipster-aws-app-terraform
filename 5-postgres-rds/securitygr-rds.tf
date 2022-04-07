resource "aws_security_group" "rds_sg" {
  name        = local.aws_rds_security_gr_name
  vpc_id      = data.aws_vpc.vpc.id
  description = "Allow 5432 Port traffic"

  ingress {
    protocol    = "tcp"
    from_port   = 5432
    to_port     = 5432
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
      Name    = local.aws_rds_security_gr_name
      AppRole = "Compute"
    }
  )
}
