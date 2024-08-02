# Internet Gateway 생성
resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "yyk-igw"
  }
}
