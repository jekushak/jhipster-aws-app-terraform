#VPC
variable "vpc_id" {
  type = string
  #default     = "10.200.0.0/16"
}

variable "instance_type" {
  type    = string
  default = "t2-micro"
}
variable "vpc_subnets_cidr_blocks" {
  type    = list(string)
  default = ["10.200.10.0/24", "10.200.20.0/24", "10.200.1.0/24", "10.200.2.0/24"]
}
