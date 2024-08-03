resource "aws_security_group" "sg_for_bastion" {
  name        = "sg_for_bastion"
  description = "Allow 22 inbound traffic"
  vpc_id      = var.vpc_id
  ingress {
    description      = "Allow SSH from anywhere"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]  # IGW
  }
  tags = {
    Name = "sg_for_bastion"
  }
}

#resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
#  security_group_id = aws_security_group.sg_for_bastion.id
#  cidr_ipv4         = var.cidr_ipv4
#  from_port         = 22
#  ip_protocol       = "tcp"
#  to_port           = 22
#}
