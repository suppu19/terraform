
resource "aws_vpc" "project" {
    cidr_block = "10.0.0.0/16"
    tags = {
    Name = "project"
  }

  }
  
resource "aws_subnet" "public_project" {
  vpc_id            = aws_vpc.project_vpc.id
  cidr_block        = "10.0.1.0/24"
  tags = {
    Name = "public_project"
  }
}
resource "aws_subnet" "pravite_project" {
  vpc_id            = aws_vpc.project_vpc.id
  cidr_block        = "10.0.2.0/24"
  tags = {
    Name = "pravite_project"
  }
}
resource "aws_internet_gateway" "ig_project" {
  vpc_id = aws_vpc.project.id

  tags = {
    Name = "Some Internet Gateway"
  }
}
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.project.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig_project.id
  }

  tags = {
    Name = "Public Route Table"
  }
resource "aws_route_table" "private-rt" { 
    vpc_id = aws_vpc.project.id

route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }

   tags = {
    Name = "private-route-table"
  } 
}

}#Elastic ip

resource "aws_eip" "auto_elb" {

}


# Nat Gateway

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.auto_elb.id
  subnet_id     = aws_subnet.public_project.id

  tags = {
    Name = "Terraform_gw_nat"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.ig_project]
}

resource "aws_route_table_association" "public_1_rt_a" {
  subnet_id      = aws_subnet.public_project.id
  route_table_id = aws_route_table.public_rt.id
}
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.pravite_project.id
  route_table_id = aws_route_table.private-rt.id
}
