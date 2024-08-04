variable "AWS_ACCESS_KEY" {
}

variable "AWS_SECRET_KEY" {
}
variable "availability_zones" {
  type    = list(string)
  default = ["ap-northeast-2a", "ap-northeast-2c"]
}

variable "AWS_REGION" {
  default = "ap-northeast-2"
}

# ami for bastion ec2
variable "ami" {
  type	  = string
  default = "ami-0443a434a57db296a" #ubuntu 22.04 LTS
}

#eks cluster name
variable "cluster_name"{
  type  = string
  default = "yyk-cluster"
}

# *****************부터 RDS*********************
variable "allocated_storage" {
  description = "The storage size of RDS"
  type        = number
  default     = 10
}

variable "db_name" {
  description = "The name must be composed of only alnum"
  type        = string
  default     = "yykdb"
}

variable "db_subnet_group_name"{
  type = string
  default = "0801 subnet"
}

variable "engine" {
  type    = string
  default = "mysql"
}

variable "engine_version" {
  type = string
  default = "8.0"
}

variable "instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "username" {
  type    = string
  default = "yyk"
}

variable "password" {
  description = "length must be longer than 8"
  type        = string
  default     = "yyk12345678"
}

variable "parameter_group_name" {
  description = "Name of the DB parameter group to associate"
  type        = string
  default     = "default.mysql8.0"
}

variable "skip_final_snapshot" {
  type    = bool
  default = true
}

variable "multi_az" {
  type    = bool
  default = true
}

# *****************까지 RDS*********************

#subnet group name
variable "name" {
  type    = string
  default = "main"
}

#variable "subnet_ids" {
#  type = list(string)
#}

variable "vpc_name" {
  type = string
  default = "my-vpc"
}
