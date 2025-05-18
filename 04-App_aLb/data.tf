data "aws_ssm_parameter" "vpc_id" {
 name  = "/${var.project-name}/${var.env}/vpc_id"
  }

data "aws_ssm_parameter" "app_alb_sg_id" {
 name  = "/${var.project-name}/${var.env}/app_alb_sg_id"
  }

  data "aws_ssm_parameter" "private-subnet-ids" {
 name  = "/${var.project-name}/${var.env}/private-subnet-ids"
  }