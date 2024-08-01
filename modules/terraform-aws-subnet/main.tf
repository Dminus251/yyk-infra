resource "aws_subnet" "main" {
  count = 1  # 실제로는 루트 모듈에서 설정된 count를 따릅니다.

  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_block
  availability_zone       = var.availability_zone
  tags = {
    Name = "Main-${count.index + 1}"  # `count.index` 사용
  }
}

