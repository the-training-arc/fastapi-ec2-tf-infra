
resource "aws_vpc" "main_vpc" {
  cidr_block           = "15.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${local.resource_prefix}-vpc"
  }
}

# ================================
# PRIVATE SUBNETS
# ================================
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "15.0.0.0/24"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "${local.resource_prefix}-private-subnet-1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "15.0.1.0/24"
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = "${local.resource_prefix}-private-subnet-2"
  }
}

resource "aws_subnet" "private_subnet_3" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "15.0.2.0/24"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "${local.resource_prefix}-private-subnet-3"
  }
}

resource "aws_subnet" "private_subnet_4" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "15.0.3.0/24"
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = "${local.resource_prefix}-private-subnet-4"
  }
}

# ================================
# PUBLIC SUBNETS
# ================================
resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "15.0.4.0/24"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "${local.resource_prefix}-public-subnet-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "15.0.5.0/24"
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = "${local.resource_prefix}-public-subnet-2"
  }
}

# ================================
# INTERNET GATEWAY
# ================================
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id

  depends_on = [aws_vpc.main_vpc]
  tags = {
    Name = "${local.resource_prefix}-igw"
  }
}

# ================================
# NAT GATEWAY
# ================================
resource "aws_eip" "nat_gateway_eip" {
  domain = "vpc"

  tags = {
    Name = "${local.resource_prefix}-nat-gateway-eip"
  }
}

resource "aws_nat_gateway" "main_nat_gateway" {
  subnet_id     = aws_subnet.public_subnet_1.id
  allocation_id = aws_eip.nat_gateway_eip.id

  tags = {
    Name = "${local.resource_prefix}-nat-gateway"
  }

  depends_on = [aws_internet_gateway.main_igw, aws_eip.nat_gateway_eip]
}

# ================================
# ROUTE TABLES
# ================================
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = {
    Name = "${local.resource_prefix}-public-route-table"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main_nat_gateway.id
  }

  tags = {
    Name = "${local.resource_prefix}-private-route-table"
  }
}

# ================================
# SUBNET ASSOCIATIONS
# ================================
resource "aws_route_table_association" "private_subnet_1_association" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_subnet_2_association" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_subnet_3_association" {
  subnet_id      = aws_subnet.private_subnet_3.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_subnet_4_association" {
  subnet_id      = aws_subnet.private_subnet_4.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "public_subnet_1_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet_2_association" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id
}
