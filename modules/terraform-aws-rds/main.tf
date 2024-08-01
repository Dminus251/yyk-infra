resource "aws_db_instance" "default" {
  allocated_storage    = 10 #10GB storage
  db_name              = "yykDB" #alnum으로만 구성
  #db_subnet_group_name = 
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "yyk"
  password             = "yyk12345678" #8글자 이상
  parameter_group_name = "default.mysql8.0" #Name of the DB parameter group to associate
  skip_final_snapshot  = true
  multi_az = true #multi AZ 사용 
}
