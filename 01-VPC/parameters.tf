 resource "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.project-name}/${var.env}/vpc_id"
  type  = "String"
  value = module.vpc.vpc_id #module should have output declaration
}

 resource "aws_ssm_parameter" "public-subnet-ids" {
  name  = "/${var.project-name}/${var.env}/public-subnet-ids"
  type  = "StringList"
  value = join(",",module.vpc.public-subnet-ids)
}


 resource "aws_ssm_parameter" "private-subnet-ids" {
  name  = "/${var.project-name}/${var.env}/private-subnet-ids"
  type  = "StringList"
  value = join(",",module.vpc.private-subnet-ids)
}


 resource "aws_ssm_parameter" "database-subnet-ids" {
  name  = "/${var.project-name}/${var.env}/database-subnet-ids"
  type  = "StringList"
  value = join(",",module.vpc.database-subnet-ids)
}