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
