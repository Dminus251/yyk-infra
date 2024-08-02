variable "vpc_id" {
  description = "The VPC ID to create the subnets in"
  type        = string
}

variable "availability_zone" {
  type = string
}

variable "cidr_block" {
  type = string
}

variable "subnet_usage" {
  description = "The usage type for the subnet (e.g., ec2, db, public)"
  type        = string
}

