variable "allocated_storage" {
  description = "The storage size of RDS"
  type        = number
}

variable "db_name" {
  description = "The name must be composed of only alnum"
  type        = string
}

variable "db_subnet_group_name"{
  type = string
}

variable "engine" {
  type    = string
}

variable "engine_version" {
  type = string
}

variable "instance_class" {
  type    = string
}

variable "username" {
  type    = string
}

variable "password" {
  description = "length must be longer than 8"
  type        = string
}

variable "parameter_group_name" {
  description = "Name of the DB parameter group to associate"
  type        = string
}

variable "skip_final_snapshot" {
  type    = bool
}

variable "vpc_security_group_ids" {
  type = list(string)
}

variable "multi_az" {
  type    = bool
}

