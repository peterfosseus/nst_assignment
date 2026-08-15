
module "ec2_server_a" {
  source = "../../modules/ec2-server"
  # base
  base_company_name = var.company_name
  base_env_name     = var.env_name
  base_service      = var.service
  base_aws_region   = var.aws_region
  # vpc
  vpc_id         = module.vpc.vpc_id
  vpc_cidr_block = module.vpc.vpc_cidr_block
  vpc_nat_gw     = module.vpc.natgw_ids[0]
  # subnet
  network_subnet_number = local.subnet.number
  network_subnet_name   = local.subnet.name
  network_subnet_type   = local.subnet.type
  # ec2 server
  ec2_server_name = local.ec2_server.name
  # ec2_server_key_name = local.ec2_server.key_pair_name
  # asg
  ec2_server_asg_min_size         = local.ec2_server.asg.min_size
  ec2_server_asg_max_size         = local.ec2_server.asg.max_size
  ec2_server_asg_desired_capacity = local.ec2_server.asg.desired_capacity
  # ami
  ec2_server_ami_image_id  = local.ec2_server.ami.image_id
  ec2_server_instance_type = local.ec2_server.instance.type
  #ec2_server_availability_zone = local.ec2_server.instance.availability_zone
  # Volume(s)
  ec2_server_volume_a_size = local.ec2_server.volume.a.size
  ec2_server_volume_a_type = local.ec2_server.volume.a.type
  # options
  ec2_server_monitoring    = local.ec2_server.monitoring
  ec2_server_ebs_optimized = local.ec2_server.ebs_optimized
  # ec2_server_disable_api_termination = local.ec2_server.disable_api_termination
  # base | alb sg id
  ec2_server_alb_sg_id = aws_security_group.elb_security_group.id
  # tg
  ec2_server_tg_protocol     = local.ec2_server.tg.protocol
  ec2_server_tg_port         = local.ec2_server.tg.port
  ec2_server_tg_health_check = local.ec2_server.tg.health_check
  # tags
  ec2_server_codedeploy_tags = local.ec2_server.code_deploy_tags
  common_tags                = local.common_tags
}
