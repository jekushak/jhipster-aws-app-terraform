# ---------------------------------------------------------------------------------------------------------------------
# Subnet
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_subnet" "public-subnet-1" {
  cidr_block              = var.public_subnets_list[0]
  vpc_id                  = aws_vpc.main.id
  availability_zone       = var.az_list[0]
  map_public_ip_on_launch = "true"
  tags = merge(
    local.common_tags,
    {
      Name    = "${local.aws_public_subnet_name}-1"
      AppRole = "Networking & Content Delivery"
    }
  )
}

resource "aws_subnet" "public-subnet-2" {
  cidr_block              = var.public_subnets_list[1]
  vpc_id                  = aws_vpc.main.id
  availability_zone       = var.az_list[1]
  map_public_ip_on_launch = "true"
  tags = merge(
    local.common_tags,
    {
      Name    = "${local.aws_public_subnet_name}-2"
      AppRole = "Networking & Content Delivery"
    }
  )
}

resource "aws_subnet" "private-subnet-1" {
  cidr_block              = var.private_subnets_list[0]
  vpc_id                  = aws_vpc.main.id
  availability_zone       = var.az_list[0]
  map_public_ip_on_launch = "true"
  tags = merge(
    local.common_tags,
    {
      Name    = "${local.aws_private_subnet_name}-1"
      AppRole = "Networking & Content Delivery"
    }
  )
}
resource "aws_subnet" "private-subnet-2" {
  cidr_block              = var.private_subnets_list[1]
  vpc_id                  = aws_vpc.main.id
  availability_zone       = var.az_list[1]
  map_public_ip_on_launch = "true"
  tags = merge(
    local.common_tags,
    {
      Name    = "${local.aws_private_subnet_name}-2"
      AppRole = "Networking & Content Delivery"
    }
  )
}
