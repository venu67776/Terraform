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
  cidr_block              = var.vpc-cidr
  availability_zone       = var.region[1]
  map_public_ip_on_launch = true

  tags      = {
    Name    = "Public Subnet 1"
  }
}