provider "aws" {
  region = "eu-north-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

module "webserver" {
  source         = "../modules/webserver"
  vpc_id         = aws_vpc.main.id
  cidr_block     = "10.0.0.0/16"
  webserver_name = "Jeku"
  ami            = "ami-08c308b1bb265e927"
  instance_type  = "t2.micro"
}

#module "db_subnet_group" {
#    source = "./modules/db_subnet_group"
#}
#module "db_postgres" {
#    source = "./modules/database_postgres"
#}
