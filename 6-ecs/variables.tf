# AWS Credentials
#variable "AWS_ACCESS_KEY" {}
#variable "AWS_SECRET_KEY" {}
#variable "region" {
#  default = "eu-north-1"
#}
variable "vpc_id" {
  default = ""
}
variable "family" {
  default = "tennis-family"
}
variable "container_port" {
  default = 8080
}
variable "task_count" {
  default = 2
}
variable "fargate_cpu" {
  default = "256"
}
variable "fargate_memory" {
  default = "512"
}
variable "db_instance_type" {
  default = "t3.micro"
}
variable "cw_log_stream" {
  default = "fargate"
}
variable "alb_security_group_id" {
  default = ""
}
variable "vpc_subnets_cidr_blocks" {
  type    = list(string)
  default = []
}
variable "alb_tg_arn" {
  type    = string
  default = ""
}
variable "alb_tg_name" {
  type    = string
  default = ""
}

