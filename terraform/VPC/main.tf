resource "aws_vpc" "techTest-VPC" {
  cidr_block           = var.cidr-block
  enable_dns_hostnames = true
  tags = {
    Name = "test"
  }
}

resource "aws_subnet" "techTest-subnet1" {
  cidr_block = var.subnet1
  vpc_id     = aws_vpc.techTest-VPC.id
  map_public_ip_on_launch = true
  availability_zone = var.az1
}

resource "aws_subnet" "techTest-subnet2" {
  cidr_block = var.subnet2
  vpc_id     = aws_vpc.techTest-VPC.id
  map_public_ip_on_launch = true
  availability_zone = var.az2
}
resource "aws_internet_gateway" "techTest-igw" {
  vpc_id = aws_vpc.techTest-VPC.id
}
resource "aws_route_table" "techTest-rt" {
    vpc_id = aws_vpc.techTest-VPC.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.techTest-igw.id
    }
}

resource "aws_route_table_association" "techTest-rta-s1" {
    subnet_id = aws_subnet.techTest-subnet1.id
    route_table_id = aws_route_table.techTest-rt.id
}

resource "aws_route_table_association" "techTest-rta-s2" {
    subnet_id = aws_subnet.techTest-subnet2.id
    route_table_id = aws_route_table.techTest-rt.id
}