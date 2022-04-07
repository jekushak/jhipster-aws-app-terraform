variable "database_identifier" {
  type    = string
  default = "jeku-postgres"
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
  default = "gp2"
  type    = string
}
variable "storage_encrypted" {
  type    = bool
  default = false
}

variable "database_port" {
  default = 5432
}

variable "vpc_security_group_ids" {
  type    = list(string)
  default = []
}
variable "db_subnet_group_name" {
  type    = string
  default = null
}
variable "parameter_group" {
  default = "default.postgres11"
  type    = string
}

variable "availability_zone" {
  type    = string
  default = "eu-north-1a"
}
variable "multi_availability_zone" {
  default = false
  type    = bool
}
variable "iops" {
  default = 100
  type    = number
}
variable "publicly_accessible" {
  type    = bool
  default = false
}
variable "backup_retention_period" {
  default = 30
}
variable "deletion_protection" {
  default = false
  type    = bool
}

variable "cloudwatch_logs_exports" {
  default = ["postgresql", "upgrade"]
  type    = list(any)
}
