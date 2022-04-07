# ---------------------------------------------------------------------------------------------------------------------
# RDS PostgreSQl
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_db_instance" "jeku-postgres" {
  identifier             = var.database_identifier
  engine                 = local.engine
  engine_version         = local.engine_version
  instance_class         = var.instance_type
  allocated_storage      = var.allocated_storage
  storage_type           = var.storage_type
  storage_encrypted      = var.storage_encrypted
  db_name                = local.aws_rds_name
  username               = local.username
  password               = local.password
  port                   = var.database_port
  vpc_security_group_ids = var.vpc_security_group_ids
  db_subnet_group_name   = var.db_subnet_group_name
  parameter_group_name   = var.parameter_group
  availability_zone      = var.availability_zone
  multi_az               = var.multi_availability_zone
  iops                   = var.iops
  publicly_accessible    = var.publicly_accessible
  #  backup_retention_period         = var.backup_retention_period
  #  deletion_protection             = var.deletion_protection
  #  enabled_cloudwatch_logs_exports = var.cloudwatch_logs_exports

}
