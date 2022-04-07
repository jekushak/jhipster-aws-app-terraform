/*# AWS Credentials
variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "region" {
  default = "eu-north-1"
}*/
variable "vpc_cidr_block" {
  default = "10.200.0.0/16"
}
variable "enable_dns_hostnames" {
  type    = bool
  default = true
}
variable "vpc_instance_tenancy" {
  default = "default"
}
variable "az_list" {
  type    = list(any)
  default = ["eu-north-1a", "eu-north-1b"]
}
variable "assign_ipv6_cidr_block" {
  default = "false"
}
variable "public_subnets_list" {
  description = "List of public subnets"
  default     = ["10.200.10.0/24", "10.200.20.0/24"]
}
variable "private_subnets_list" {
  description = "List of private subnets"
  default     = ["10.200.1.0/24", "10.200.2.0/24"]
}
