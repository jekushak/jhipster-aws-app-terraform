# ---------------------------------------------------------------------------------------------------------------------
# RDS PostgreSQl
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_db_instance" "postgres" {
  identifier                      = local.aws_rds_db_identifier
  engine                          = local.engine
  engine_version                  = local.engine_version
  instance_class                  = var.instance_type
  allocated_storage               = var.allocated_storage
  storage_type                    = var.storage_type
  storage_encrypted               = var.storage_encrypted
  db_name                         = "postgres" #local.aws_rds_name
  username                        = local.username
  password                        = local.password
  port                            = var.database_port
  vpc_security_group_ids          = [aws_security_group.rds_sg.id]
  db_subnet_group_name            = aws_db_subnet_group.subnets-group.id
  parameter_group_name            = aws_db_parameter_group.parametergroup.name
  availability_zone               = var.availability_zone
  multi_az                        = var.multi_availability_zone
  publicly_accessible             = var.publicly_accessible
  skip_final_snapshot             = var.skip_final_snapshot
  final_snapshot_identifier       = var.final_snapshot_identifier
  backup_retention_period         = var.backup_retention_period
  deletion_protection             = var.deletion_protection
  enabled_cloudwatch_logs_exports = var.cloudwatch_logs_exports
  tags = merge(
    local.common_tags,
    {
      Name    = local.aws_db_parameter_gr
      AppRole = "Database"
    }
  )
}
# ---------------------------------------------------------------------------------------------------------------------
# DB Subnet Group
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_db_subnet_group" "subnets-group" {
  name       = local.aws_db_subnetsgroup
  subnet_ids = var.rds_subnet_ids
  tags = merge(
    local.common_tags,
    {
      Name    = local.aws_db_subnetsgroup
      AppRole = "Database"
    }
  )
  lifecycle {
    create_before_destroy = false
  }
}
# ---------------------------------------------------------------------------------------------------------------------
# DB Parameter Group
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_db_parameter_group" "parametergroup" {
  name   = local.aws_db_parameter_gr
  family = var.family
  parameter {
    apply_method = "immediate"
    name         = "autovacuum_naptime"
    value        = "30"
  }
  parameter {
    apply_method = "pending-reboot"
    name         = "autovacuum_max_workers"
    value        = "15"
  }
  tags = merge(
    local.common_tags,
    {
      Name    = local.aws_db_parameter_gr
      AppRole = "Database"
    }
  )
  lifecycle {
    create_before_destroy = false
  }
}




