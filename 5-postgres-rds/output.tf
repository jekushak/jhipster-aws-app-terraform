output "rds_hostname" {
  value     = aws_db_instance.postgres
  sensitive = true
}
output "rds_username" {
  value     = aws_db_instance.postgres
  sensitive = true
}
output "cluster_endpoint" {
  value = aws_db_instance.postgres.endpoint
}
