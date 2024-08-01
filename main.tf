module "vpc" {
  source 	= "./modules/terraform-aws-vpc"  # 로컬 모듈 경로
  vpc_name      = "my-vpc"
  vpc_cidr	= "10.0.0.0/16"
}


module "subnet" {
  source        = "./modules/terraform-aws-subnet"
  count         = length(var.availability_zones) * 2  # 두 개의 가용 영역에 대해 각각 2개의 서브넷
  cidr_block    = cidrsubnet(module.vpc.vpc_cidr, 4, count.index)  # 서브넷의 CIDR 블록 계산
  availability_zone = var.availability_zones[floor(count.index/2)]  # 가용 영역 할당
  vpc_id        = module.vpc.vpc_id
}

