# AWS Credentials
#variable "AWS_ACCESS_KEY" {}
#variable "AWS_SECRET_KEY" {}
#variable "region" {
#  default = "eu-north-1"
#}
variable "vpc_id" {
  default = ""
}
variable "private_subnets_cidr_blocks" {
  type    = list(string)
  default = []
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "instance_count" {
  type    = number
  default = 1
}
