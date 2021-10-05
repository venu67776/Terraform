variable "region" {
  default       = "us-east-1"
  description   = "AWS Region"
  type          = string
}

variable "vpc-cidr" {
  default       = "10.0.0.0/16"
  description   = "VPC CIDR Block"
  type          = string
}

variable "public-subnet-1-cidr" {
  default       = "10.0.1.0/24"
  description   = "Private Subnet 1 CIDR Block"
  type          = string
}

variable "public-subnet-2-cidr" {
  default       = "10.0.2.0/24"
  description   = "Private Subnet 2 CIDR Block"
  type          = string
}

variable "public-subnet-3-cidr" {
  default       = "10.0.3.0/24"
  description   = "Private Subnet 3 CIDR Block"
  type          = string
}