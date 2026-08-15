
# data "aws_ami" "server" {
#   most_recent = true
#
#   filter {
#     name   = "name"
#     values = [var.ec2_server_ami_filter_name]
#   }
#
#   filter {
#     name   = "architecture"
#     values = [var.ec2_server_ami_filter_architecture]
#   }
#
#   filter {
#     name   = "virtualization-type"
#     values = [var.ec2_server_ami_filter_virtualization_type]
#   }
#
#   filter {
#     name   = "image-type"
#     values = ["machine"]
#   }
#   #owners = ["679593333241"] # aws-marketplace
#   owners = [var.ec2_server_ami_filter_owners]
# }
