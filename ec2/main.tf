provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_instance" "venu" {
  ami           = "ami-09e67e426f25ce0d7"
  instance_type = "t2.micro"
  count         = var.instance_count    

  tags = {
    Name = var.instance_name
  }
}
output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.venu.id
}