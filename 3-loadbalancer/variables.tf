# AWS Credentials
#variable "AWS_ACCESS_KEY" {}
#variable "AWS_SECRET_KEY" {}
#variable "region" {
#  default = "eu-north-1"
#}
variable "vpc_id" {
  default = "vpc-xxx"
}
variable "public_subnets_cidr_blocks" {
  type    = list(string)
  default = []
}
variable "load_balancer_type" {
  type    = string
  default = "application"
}
variable "internal" {
  type    = bool
  default = false
}
variable "enable_deletion_protection" {
  type    = bool
  default = false
}
variable "http_tcp_listeners" {
  type    = any
  default = ["80", "8080"]
}
