# ---------------------------------------------------------------------------------------------------------------------
# Subnet
# ---------------------------------------------------------------------------------------------------------------------
terraform {
  required_version = ">= 0.12"
}

resource "aws_subnet" "public-subnet-1" {
  cidr_block              = var.vpc_subnets_cidr_blocks[0]
  vpc_id                  = var.vpc_id
  availability_zone       = "eu-north-1a"
  map_public_ip_on_launch = "true"
  tags = merge(
    local.common_tags,
    {
      Name    = "${local.aws_public_subnet_name}-1"
      AppRole = "Networking & Content Delivery"
    }
  )
}

resource "aws_instance" "webserver" {
  ami           = nonsensitive(data.aws_ssm_parameter.ami.value)
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public-subnet-1.id
  tags = merge(
    local.common_tags,
    {
      Name    = "${local.aws_ec2_name}-1"
      AppRole = "Networking & Content Delivery"
    }
  )
}
