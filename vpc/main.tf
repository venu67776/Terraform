# terraform {
#   backend "remote" {
#     organization = "venuzs"

#     workspaces {
#       name = "venu"
#     }
#   }
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 3.27"
#     }
#   }

#   required_version = ">= 0.14.9"
# }

#  terraform {
#   backend "s3" {
#     bucket = "venu6766"
#     key    = "terraform.tfstate"
#     region = "us-east-1"
#     profile = "default"
#     shared_credentials_file = "C:/Users/.aws/credentials"
#   }

#    required_providers {
#     aws = {
#        source  = "hashicorp/aws"
#        version = "~> 3.27"
#      }
#    }

#    required_version = ">= 0.14.9"
#  }

provider "aws" {
  profile = "default"
  region  = var.region
  shared_credentials_file = "C:/Users/.aws/credentials"
}

/*create vpc*/
resource "aws_vpc" "vpc" {
  cidr_block              = var.vpc-cidr
  instance_tenancy        = "default"
  enable_dns_hostnames    = true

  tags      = {
    Name    = "vpc1"
  }
}

/*creating internet_gateway*/
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "IGW"
  }
}

/*creating public subnets*/
resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public-subnet-1-cidr
  availability_zone       = "us-east-1a"
  
  tags      = {
    Name    = "Public Subnet 1"
  }
}

resource "aws_subnet" "public-subnet-2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public-subnet-2-cidr
  availability_zone       = "us-east-1b"
  
  tags      = {
    Name    = "Public Subnet 2"
  }
}

resource "aws_subnet" "public-subnet-3" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public-subnet-3-cidr
  availability_zone       = "us-east-1c"

  tags      = {
    Name    = "Public Subnet 3"
  }
}

/*creating public routetable*/
resource "aws_route_table" "public-route-table" {
  vpc_id       = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags       = {
    Name     = "Public Route Table"
  }
}

/*Associate Public Subnets to routetables*/
resource "aws_route_table_association" "public-subnet-1-route-table-association" {
  subnet_id           = aws_subnet.public-subnet-1.id
  route_table_id      = aws_route_table.public-route-table.id
}
resource "aws_route_table_association" "public-subnet-3-route-table-association" {
  subnet_id           = aws_subnet.public-subnet-2.id
  route_table_id      = aws_route_table.public-route-table.id
}
resource "aws_route_table_association" "public-subnet-2-route-table-association" {
  subnet_id           = aws_subnet.public-subnet-3.id
  route_table_id      = aws_route_table.public-route-table.id
}

/*creating private subnets*/
resource "aws_subnet" "private-subnet-1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private-subnet-1-cidr
  availability_zone       = "us-east-1a"
 
  tags      = {
    Name    = "private Subnet 1"
  }
}

resource "aws_subnet" "private-subnet-2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private-subnet-2-cidr
  availability_zone       = "us-east-1b"
  
  tags      = {
    Name    = "private Subnet 2"
  }
}

resource "aws_subnet" "private-subnet-3" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private-subnet-3-cidr
  availability_zone       = "us-east-1c"
 
  tags      = {
    Name    = "private Subnet 3"
  }
}

/*terraform aws allocate elastic ip*/
resource "aws_eip" "eip-for-nat-gateway-1" {
  vpc    = true

  tags   = {
    Name = "EIP-1"
  }
}


/*Create Nat Gateway  in Public Subnets*/

resource "aws_nat_gateway" "nat-gateway-1" {
  allocation_id = aws_eip.eip-for-nat-gateway-1.id
  subnet_id     = aws_subnet.public-subnet-1.id

  tags   = {
    Name = "Nat Gateway Public Subnet 1"
  }
}

/*Create Private Route Tables and Add Route Through Nat Gateway */

resource "aws_route_table" "private-route-table" {
  vpc_id            = aws_vpc.vpc.id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.nat-gateway-1.id
  }

  tags   = {
    Name = "Private Route Table"
  }
}

resource "aws_route_table_association" "private-subnet-1_route-table-association" {
  subnet_id         = aws_subnet.private-subnet-1.id
  route_table_id    = aws_route_table.private-route-table.id
}
resource "aws_route_table_association" "private-subnet-2_route-table-association" {
  subnet_id         = aws_subnet.private-subnet-2.id
  route_table_id    = aws_route_table.private-route-table.id
}
resource "aws_route_table_association" "private-subnet-3_route-table-association" {
  subnet_id         = aws_subnet.private-subnet-3.id
  route_table_id    = aws_route_table.private-route-table.id
}