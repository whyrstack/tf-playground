resource "aws_vpc" "this" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = var.vpc_name
    Terraform   = "true"
    Environment = "Production"
  }
}

# Public subnet setup
resource "aws_subnet" "public-1" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.cidr_public_subnet_1
  availability_zone = var.az_public_subnet_1
  tags = {
    Name        = "${var.vpc_name}-public-subnet-1"
    Terraform   = "true"
    Environment = "Production"
  }
}

resource "aws_subnet" "public-2" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.cidr_public_subnet_2
  availability_zone = var.az_public_subnet_2
  tags = {
    Name        = "${var.vpc_name}-public-subnet-2"
    Terraform   = "true"
    Environment = "Production"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name        = "my-public-igw"
    Terraform   = "true"
    Environment = "Production"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }


  tags = {
    Name        = "${var.vpc_name}-rt-public"
    Terraform   = "true"
    Environment = "Production"
  }
}

resource "aws_route_table_association" "FE-1" {
  subnet_id      = aws_subnet.public-1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "FE-2" {
  subnet_id      = aws_subnet.public-2.id
  route_table_id = aws_route_table.public.id
}

# Private subnet setup

resource "aws_subnet" "private-1" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.cidr_private_subnet_1
  availability_zone = var.az_private_subnet_1
  tags = {
    Name        = "${var.vpc_name}-private-subnet-1"
    Terraform   = "true"
    Environment = "Production"
  }
}

resource "aws_subnet" "private-2" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.cidr_private_subnet_2
  availability_zone = var.az_private_subnet_2
  tags = {
    Name        = "${var.vpc_name}-private-subnet-2"
    Terraform   = "true"
    Environment = "Production"
  }
}
