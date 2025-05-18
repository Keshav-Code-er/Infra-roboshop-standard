locals {
  db_subnet_id = element(split(",", data.aws_ssm_parameter.database-subnet-ids.value),0)
}