module "mysql_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.devOps_ami.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.mysql_sg_id.value]

  #it should be in Roboshop DB Subnet
  subnet_id = local.db_subnet_id
  user_data = file("mysql.sh")
  #this is optional,if we dont give this will be provisioned inside default subnet of default vpc
  #subnet_id = local.public_ids[0] # public subnet of default VPC
   
  tags = merge(
    {
        Name = "mysql"
    },
    var.common_tags
  )

}

module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 3.0"
  zone_name = var.zone_name
  records =[
     {
      name    = "mysql"
      type    = "A"
      ttl     = 1
      records = [
        module.mysql_instance.private_ip
      ]
    }
  ]
}