variable "vpc_id" {
  description = "The VPC ID to create the subnets in"
  type        = string
}

variable "availability_zone" {
  type    = string
}

variable "cidr_block"{
  type = string
}

#variable "subnet_count"{
  #type = number
#}
