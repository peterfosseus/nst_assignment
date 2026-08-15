
# output "ami_found" {
#   value = data.aws_ami.server
# }

output "target_group_arn" {
  value = aws_lb_target_group.target_group.arn
}

output "private_security_group_id" {
  value = aws_security_group.private_security_group.id
}

output "target_group_name" {
  value = aws_lb_target_group.target_group.name
}

output "target_group_arn_suffix" {
  value = aws_lb_target_group.target_group.arn_suffix
}

output "asg_name" {
  value = aws_autoscaling_group.server_asg.name
}

output "autoscaling_group_name" {
  value = aws_autoscaling_group.server_asg.name
}
