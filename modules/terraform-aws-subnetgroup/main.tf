resource "aws_db_subnet_group" "yyk-subnetgroup" {
  name       = var.name
  subnet_ids = var.subnet_ids
tags = {
    Name = "My DB subnet group"
  }
}
