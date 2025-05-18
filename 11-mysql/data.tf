data "aws_ssm_parameter" "vpc_id" {
 name  = "/${var.project-name}/${var.env}/vpc_id"
  }

data "aws_ssm_parameter" "vpn_sg_id" {
 name  = "/${var.project-name}/${var.env}/vpn_sg_id"
  }

data "aws_ssm_parameter" "database-subnet-ids" {
 name  = "/${var.project-name}/${var.env}/database-subnet-ids"
  }

  data "aws_ssm_parameter" "mysql_sg_id" {
 name  = "/${var.project-name}/${var.env}/mysql_sg_id"
  }

  data "aws_ami" "devOps_ami" {
  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"
  owners           = ["973714476881"]

  filter {
    name   = "name"
    values = ["Centos-8-DevOps-Practice"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}