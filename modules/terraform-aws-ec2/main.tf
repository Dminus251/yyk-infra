resource "aws_instance" "bastion" {
  ami           = var.ami
  instance_type = "t3.micro"
  subnet_id     = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  associate_public_ip_address = true 
  key_name = var.key_name
  tags = {
    Name = "bastion"
  }
}
