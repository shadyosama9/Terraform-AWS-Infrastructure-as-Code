# Creating The VPC
resource "aws_vpc" "terra-vpc" {
  cidr_block       = var.CIDR
  instance_tenancy = "default"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Terra-VPC"
  }
}


## Creating Subnets

# Public  Subnet
resource "aws_subnet" "Terra-PUB-SUB" {
  vpc_id                  = aws_vpc.terra-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = var.AZS[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "Terra-PUB-SUB"
  }
}

# Private Subnet
resource "aws_subnet" "Terra-PRIV-SUB" {
  vpc_id            = aws_vpc.terra-vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = var.AZS[1]

  tags = {
    Name = "Terra-PRIV-SUB"
  }
}



# Creating The Internet Gateway For The VPC
resource "aws_internet_gateway" "Terra-IGW" {
  vpc_id = aws_vpc.terra-vpc.id

  tags = {
    Name = "Terra-IGW"
  }
}



#Creating The Public Route Table And Accosiating The Subnet
resource "aws_route_table" "Terra-PUB-Table" {
  vpc_id = aws_vpc.terra-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Terra-IGW.id

  }

  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_route_table_association" "Public" {
  subnet_id      = aws_subnet.Terra-PUB-SUB.id
  route_table_id = aws_route_table.Terra-PUB-Table.id
}


# Elastic IP For The NAT Gate Way
resource "aws_eip" "NAT-EIB" {}


# NAT Gate Way
resource "aws_nat_gateway" "Terra-NAT" {
  allocation_id = aws_eip.NAT-EIB.id
  subnet_id     = aws_subnet.Terra-PUB-SUB.id

  depends_on = [aws_internet_gateway.Terra-IGW]

  tags = {
    Name = "Terra NAT Gateway"
  }
}



#Creating The Private Route Table And Accosiating The Subnet
resource "aws_route_table" "Terra-Priv-Table" {
  vpc_id = aws_vpc.terra-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.Terra-NAT.id
  }

  tags = {
    Name = "Private Route Table"
  }
}

resource "aws_route_table_association" "Private" {
  subnet_id      = aws_subnet.Terra-PRIV-SUB.id
  route_table_id = aws_route_table.Terra-Priv-Table.id
}
