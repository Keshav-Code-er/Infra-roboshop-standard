module "payment_component" {
  source       = "../../terraform-app-module-roboshop"
  env          = var.env
  common_tags  = var.common_tags
  project-name = var.project-name

  #target group variables
  target_group_port = var.target_group_port
  #health_check      = var.health_check
  vpc_id            = data.aws_ssm_parameter.vpc_id.value

  #launch temlate variables
  image_id             = data.aws_ami.devOps_ami.id
  instance_type        = var.instance_type
  security_Group_Id    = data.aws_ssm_parameter.payment_sg_id.value
  launch_template_tags = var.launch_template_tags
  user_data            = filebase64("${path.module}/payment.sh")

  #auto_scaling_variables
  vpc_zone_identifier = split(",", data.aws_ssm_parameter.private-subnet-ids.value)
  tags                = var.auto_scaling_tags


#autoscaling_policy I'm good with optional


#aws_lb_listener_rule
listener_arn = data.aws_ssm_parameter.app_alb_listener_arn.value
listener_rule_priority = 50 #user already have 30
host_header = "payment.app.joindevops.shop" # someone calls on this , app alb redirect to cart instance


}