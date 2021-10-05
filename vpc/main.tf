terraform {
  /*backend "remote" {
  organization = "venuzs"
  workspaces {
     name = "venu"
   }*/
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = var.region
}

#create a vpc
resource "aws_vpc" "vpc" {
  cidr_block              = var.vpc-cidr
  instance_tenancy        = "default"
  enable_dns_hostnames    = true

  tags      = {
    Name    = "vpc1"
  }
}

resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public-subnet-1-cidr
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags      = {
    Name    = "Public Subnet 1"
  }
}

resource "aws_subnet" "public-subnet-2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public-subnet-2-cidr
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags      = {
    Name    = "Public Subnet 2"
  }
}

resource "aws_subnet" "public-subnet-3" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public-subnet-3-cidr
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true

  tags      = {
    Name    = "Public Subnet 3"
  }
}