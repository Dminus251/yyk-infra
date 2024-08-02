module "vpc" {
  source 	= "./modules/terraform-aws-vpc"  # 로컬 모듈 경로
  vpc_name      = "my-vpc" #나중에 var로 변경하자
  vpc_cidr	= "10.0.0.0/16"
}


module "private_subnet" {
  source        = "./modules/terraform-aws-subnet"
  count         = length(var.availability_zones) * 2  # 두 개의 가용 영역에 대해 각각 2개의 서브넷
  cidr_block    = cidrsubnet(module.vpc.vpc_cidr, 4, count.index)  # 서브넷의 CIDR 블록 계산
  availability_zone = var.availability_zones[floor(count.index/2)]  # 가용 영역 할당
  vpc_id        = module.vpc.vpc_id
  subnet_usage        = element(["ec2", "db"], count.index % 2)  # 서브넷 용도 할당
}

module "public_subnet"{
  source        = "./modules/terraform-aws-subnet"
  count         = length(var.availability_zones) 
  cidr_block    = cidrsubnet(module.vpc.vpc_cidr, 4, count.index + length(var.availability_zones) * 2) 
  availability_zone = var.availability_zones[count.index] 
  vpc_id        = module.vpc.vpc_id
  subnet_usage  = "public"
}

module "igw"{
  source	= "./modules/terraform-aws-igw"
  vpc_id	= module.vpc.vpc_id
}

module "route_table"{
  source	= "./modules/terraform-aws-route_table"
  vpc_id	= module.vpc.vpc_id
  cidr_block	= "0.0.0.0/0" #나중에 수정
  gateway_id	= module.igw.igw_id

}

module "route_table_association"{
  source	 = "./modules/terraform-aws-route_table_association"
  count          = length(var.availability_zones) 
  #subnet_ids	 = [
  #  for s in module.public_subnet : s.id
  #]
  #subnet_id 	 = subnet_ids[count.index]
  subnet_id	 = module.public_subnet[count.index].id #select public subnet 
  route_table_id = module.route_table.route_table_id #associate public subnet with route table
}

/*
module "rds"{
  depends_on = [module.subnetgroup]
  source = "./modules/terraform-aws-rds"
  
  allocated_storage    = var.allocated_storage
  db_name              = var.db_name
  db_subnet_group_name = module.subnetgroup.name
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  username             = var.username
  password             = var.password
  parameter_group_name = var.parameter_group_name
  skip_final_snapshot  = var.skip_final_snapshot
  multi_az = var.multi_az
}

module "subnetgroup"{
  source = "./modules/terraform-aws-subnet_group"
  name       = var.name
  subnet_ids = [
    for s in module.private_subnet : s.id if s.subnet_usage == "db"
  ]
}

output "subnetgroup_name" {
  value = module.subnetgroup.name #main
}
*/
