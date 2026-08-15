
resource "aws_autoscaling_group" "server_asg" {
  name = "${var.base_company_name}-${var.base_env_name}-${var.network_subnet_type}-${var.network_subnet_name}-asg"
  vpc_zone_identifier = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id,
  ]
  min_size         = var.ec2_server_asg_min_size
  max_size         = var.ec2_server_asg_max_size
  desired_capacity = var.ec2_server_asg_desired_capacity

  # Turn on ELB Health Check
  #health_check_type                = "ELB"

  launch_template {
    id      = aws_launch_template.server_launch_template.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.target_group.arn]

  depends_on = [
    aws_launch_template.server_launch_template,
    aws_lb_target_group.target_group
  ]
}

resource "aws_launch_template" "server_launch_template" {
  name          = "${var.base_company_name}-${var.base_env_name}-${var.network_subnet_type}-${var.network_subnet_name}-launch-template"
  description   = "${var.base_company_name}-${var.base_env_name}-${var.network_subnet_type}-${var.network_subnet_name}-launch-template"
  image_id      = var.ec2_server_ami_image_id
  instance_type = var.ec2_server_instance_type
  # key_name      = var.ec2_server_key_name
  ebs_optimized = var.ec2_server_ebs_optimized
  user_data     = base64encode(file("${path.module}/ec2-user-data.sh"))

  iam_instance_profile {
    name = aws_iam_instance_profile.profile.name
  }

  monitoring {
    enabled = var.ec2_server_monitoring
  }

  network_interfaces {
    subnet_id       = aws_subnet.private_a.id
    security_groups = [aws_security_group.private_security_group.id]
  }

  lifecycle {
    create_before_destroy = true
  }

  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      delete_on_termination = true
      encrypted             = true
      volume_size           = var.ec2_server_volume_a_size
      volume_type           = var.ec2_server_volume_a_type
      kms_key_id            = var.ec2_server_aws_kms_key_id
    }
  }

  metadata_options {
    http_tokens = "required"
  }

  tag_specifications {
    resource_type = "instance"
    tags = merge(
      local.ec2_server.tags,
      var.ec2_server_codedeploy_tags,
      var.common_tags
    )
  }

  tag_specifications {
    resource_type = "volume"
    tags          = local.ec2_server.volume.tags
  }

  depends_on = [
    aws_subnet.private_a,
    aws_security_group.private_security_group,
    aws_iam_instance_profile.profile
  ]
}
