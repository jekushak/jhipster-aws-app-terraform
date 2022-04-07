# ---------------------------------------------------------------------------------------------------------------------
# Route
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    local.common_tags,
    {
      Name    = "${local.aws_vpc_name}-public-route"
      AppRole = "Networking & Content Delivery"
    }
  )
}
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

### Private Route
resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    local.common_tags,
    {
      Name    = "${local.aws_vpc_name}-private-route"
      AppRole = "Networking & Content Delivery"
    }
  )
}

resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.private-route-table.id
  nat_gateway_id         = aws_nat_gateway.natgw.id
  destination_cidr_block = "0.0.0.0/0"
  depends_on = [
    aws_route_table.private-route-table,
    aws_nat_gateway.natgw,
  ]
}
resource "aws_route_table_association" "rta-public-subnet" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.public-route-table.id
}
resource "aws_route_table_association" "rta-private-subnet" {
  subnet_id      = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.private-route-table.id
}
