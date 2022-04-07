# AWS Credentials
#variable "AWS_ACCESS_KEY" {}
#variable "AWS_SECRET_KEY" {}
#variable "region" {
#  default = "eu-north-1"
#}
variable "vpc_id" {
  default = ""
}
variable "instance_type" {
  default = "db.t3.micro"
  type    = string
}
variable "allocated_storage" {
  type    = number
  default = 20
}
variable "storage_type" {
  type    = string
  default = "gp2"
}
variable "storage_encrypted" {
  type    = bool
  default = false
}
variable "database_port" {
  default = 5432
}
variable "availability_zone" {
  type    = string
  default = "eu-north-1a"
}
variable "multi_availability_zone" {
  type    = bool
  default = false
}
variable "iops" {
  default = 1000
  type    = number
}
variable "publicly_accessible" {
  type    = bool
  default = false
}
variable "backup_retention_period" {
  default = 7
}
variable "deletion_protection" {
  type    = bool
  default = false
}
variable "skip_final_snapshot" {
  type    = bool
  default = true
}
variable "final_snapshot_identifier" {
  type    = string
  default = "final"
}
variable "cloudwatch_logs_exports" {
  type    = list(any)
  default = ["postgresql", "upgrade"]
}
variable "rds_subnet_ids" {
  type    = list(string)
  default = []
}
variable "family" {
  type    = string
  default = "postgres13"
}
