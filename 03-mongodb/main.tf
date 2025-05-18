# module "mongodb_sg" {
#     source = "../../terraform-aws-sg"
#     project_name = var.project-name
#     sg_name         = "mongodb"
#     sg_description  = "Allow traffic"
#     #sg_ingress-rule = var.sg_ingress-rule
#     vpc_id = data.aws_ssm_parameter.vpc_id.value
#     common_tags = var.common_tags
  
# }

#inbound rules
# resource "aws_security_group_rule" "mongodb_vpn" {
#   type              = "ingress"
#   from_port         = 22
#   to_port           = 22  
#   protocol          = "tcp"
#   # insted od adding cidr to source we are directly adding the SG id to inbound rule(now vpn instace allow the traffic to mongodb sg)
#   source_security_group_id = data.aws_ssm_parameter.vpn_sg_id.value
#   #cidr_blocks       = ["${chomp(data.http.myip.response_body)}/32"]
#   #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
#   security_group_id = module.mongodb_sg.security_Group
# } 

module "mongodb_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.devOps_ami.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.mongodb_sg_id.value]

  #it should be in Roboshop DB Subnet
  subnet_id = local.db_subnet_id
  user_data = file("mongodb.sh")
  #this is optional,if we dont give this will be provisioned inside default subnet of default vpc
  #subnet_id = local.public_ids[0] # public subnet of default VPC
   
  tags = merge(
    {
        Name = "mongodb"
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
      name    = "mongodb"
      type    = "A"
      ttl     = 1
      records = [
        module.mongodb_instance.private_ip
      ]
    }
  ]
}