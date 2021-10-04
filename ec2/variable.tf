variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "venu123"
}
variable "instance_count" {
  default = "2"
}