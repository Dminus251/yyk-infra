resource "aws_subnet" "main" {
  count = 1 #이거 안 하면 tags에서 에러남..

  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_block
  availability_zone       = var.availability_zone
  tags = {
    Name = "Main-${count.index + 1}"  # `count.index` 사용
  }
}

