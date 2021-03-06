 terraform {
  backend "s3" {
    bucket = "venu6776"
    key    = "terraform.tfstate"
    region = "us-east-1"
    profile = "default"
    shared_credentials_file = "C:/Users/.aws/credentials"
  }

   required_providers {
    aws = {
       source  = "hashicorp/aws"
       version = "~> 3.27"
     }
   }

   required_version = ">= 0.14.9"
 }


provider "aws" {
  shared_credentials_file = "C:/Users/.aws/credentials"
  profile = "default"
  region  = "us-east-1"
}

resource "aws_instance" "venu" {
  ami           = "ami-09e67e426f25ce0d7"
  instance_type = "t2.micro"
  /*count         = var.instance_count */

  tags = {
    Name = var.instance_name
  }
}
/*resource "aws_eip" "lb" {
  instance = aws_instance.venu.id
  vpc      = true
}*/

# resource "aws_ebs_volume" "venu" {
#   availability_zone = aws_instance.venu.availability_zone
#   size              = 1

#   tags = {
#     Name = "venuebs"
#   }
# }
# resource "aws_volume_attachment" "venuebs" {
#   device_name = "/dev/sdh"
#   volume_id   = aws_ebs_volume.venu.id
#   instance_id = aws_instance.venu.id
# }