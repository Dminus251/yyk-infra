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

variable "engine" {
  type    = string
  default = "mysql"
}

variable "engine_version" {
  type = string
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

