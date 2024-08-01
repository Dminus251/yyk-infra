module "vpc" {
  source 	= "./modules/terraform-aws-vpc"  # 로컬 모듈 경로
  vpc_name      = "my-vpc" #나중에 var로 변경하자
  vpc_cidr	= "10.0.0.0/16"
}


module "subnet" {
  source        = "./modules/terraform-aws-subnet"
  count         = length(var.availability_zones) * 2  # 두 개의 가용 영역에 대해 각각 2개의 서브넷
  cidr_block    = cidrsubnet(module.vpc.vpc_cidr, 4, count.index)  # 서브넷의 CIDR 블록 계산
  availability_zone = var.availability_zones[floor(count.index/2)]  # 가용 영역 할당
  vpc_id        = module.vpc.vpc_id
  subnet_usage        = element(["ec2", "db"], count.index % 2)  # 서브넷 용도 할당
}

module "rds"{
  source = "./modules/terraform-aws-rds"
  
  allocated_storage    = var.allocated_storage
  db_name              = var.db_name
  #db_subnet_group_name =
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  username             = var.username
  password             = var.password
  parameter_group_name = var.parameter_group_name
  skip_final_snapshot  = var.skip_final_snapshot
  multi_az = var.multi_az
}
