
# *********db uri 만들 때 사용***************
output "db_endpoint" {
  value = module.rds.db_endpoint
}
output "db_name" {
  value = module.rds.db_name
}

output "db_user" {
  value = module.rds.db_user
}


output "db_password" {
  value = module.rds.db_password
  sensitive = true
}
# *******************************************

output "security_group_ids_in_rds"{
  value = module.rds.vpc_security_group_ids
}

output "subnetgroup_name" {
  value = module.subnetgroup.name #main
}

output "private_subnet_ids" {
  value = module.private_subnet.*.ids
}

output "public_subnet_ids" {
  value = module.public_subnet.*.ids
}

output "bastion_id" {
  value = module.bastion.id
}

output "id" {
  value = module.sg_for_bastion.id
}

