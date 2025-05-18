data "aws_ssm_parameter" "vpc_id" {
 name  = "/${var.project-name}/${var.env}/vpc_id"
  }

data "aws_ssm_parameter" "web_alb_sg_id" {
 name  = "/${var.project-name}/${var.env}/web_alb_sg_id"
  }

  data "aws_ssm_parameter" "public-subnet-ids" {
 name  = "/${var.project-name}/${var.env}/public-subnet-ids"
  }