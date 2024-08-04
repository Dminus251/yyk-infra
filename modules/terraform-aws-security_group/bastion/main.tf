resource "aws_security_group" "sg_for_bastion" {
  name        = "sg_for_bastion"
  description = "Allow 22 inbound traffic"
  vpc_id      = var.vpc_id

  #ssh 허용
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]  # IGW
  }

  

#아웃바운드
  #이게 디폴트로 적용되는 줄 알았는데 이걸 해야 트래픽이 나감
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "sg_for_bastion"
  }
}

