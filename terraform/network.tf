
resource "aws_vpc" "exam_itea_vpc" {
  cidr_block           = "172.31.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  enable_classiclink   = false
  instance_tenancy     = "default"

  tags = {
    "Name" = "exam_itea_vpc"
  }
}

resource "aws_subnet" "exam_itea_subnet" {
  vpc_id                  = aws_vpc.exam_itea_vpc.id
  cidr_block              = "172.31.0.0/20"
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1a"

  tags = {
    "Name" = "exam_itea_subnet"
  }
}

resource "aws_internet_gateway" "exam_itea_igw" {
  vpc_id = aws_vpc.exam_itea_vpc.id

  tags = {
    "Name" = "exam_itea_igw"
  }
}

resource "aws_route_table" "exam_itea_public_crt" {
  vpc_id = aws_vpc.exam_itea_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.exam_itea_igw.id
  }

  tags = {
    Name = "exam_itea_public_crt"
  }
}

resource "aws_route_table_association" "aws_exam_item_rta" {
  subnet_id      = aws_subnet.exam_itea_subnet.id
  route_table_id = aws_route_table.exam_itea_public_crt.id
}

resource "aws_security_group" "exam_itea_sg" {
  vpc_id = aws_vpc.exam_itea_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "exam_itea-all"
  }
}