resource "aws_security_group" "sg_for_db" {
  name        = "sg_for_db"
  description = "Allow 3306 inbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "sg_for_db"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.sg_for_db.id
  cidr_ipv4         = var.cidr_ipv4
  from_port         = 3306
  ip_protocol       = "tcp"
  to_port           = 3306
}
