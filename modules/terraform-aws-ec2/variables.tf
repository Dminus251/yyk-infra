variable "subnet_id"{
  type = string
}

variable "ami" {
  type = string
  default = "ami-0443a434a57db296a" #ap-northeast-2의 ubuntu 22.04 LTS
}

variable "vpc_security_group_ids"{
  type = list(string)
}

variable "associate_public_ip_address"{
  type = bool
  default = true
}

variable "key_name"{
  type = string
  default = "0802"
}
