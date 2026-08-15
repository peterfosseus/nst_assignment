
# VPC

variable "vpc_id" {
  description = "vpc_id"
  type        = string
  default     = ""
}

variable "vpc_cidr_block" {
  description = "vpc_cidr_block"
  type        = string
  default     = "required-variable-not-set"
}

variable "vpc_nat_gw" {
  description = "vpc_nat_gw"
  type        = string
  default     = ""
}

# Subnet

variable "network_subnet_number" {
  description = "network_subnet_number"
  type        = number
  default     = null
}

variable "network_subnet_name" {
  description = "network_subnet_name"
  type        = string
  default     = ""
}

variable "network_subnet_type" {
  description = "network_subnet_type"
  type        = string
  default     = ""
}

# Server variables

variable "base_company_name" {
  description = "company_name"
  type        = string
  default     = ""
}

variable "base_env_name" {
  description = "env_name"
  type        = string
  default     = ""
}

variable "base_service" {
  description = "service"
  type        = string
  default     = ""
}

variable "base_aws_region" {
  description = "aws_region"
  type        = string
  default     = ""
}

variable "ec2_server_name" {
  description = "name"
  type        = string
  default     = ""
}

variable "ec2_server_ebs_optimized" {
  description = "ebs_optimized"
  type        = string
  default     = ""
}

# variable "ec2_server_disable_api_termination" {
#   description = "Description"
#   type        = string
#   default     = ""
# }

variable "ec2_server_monitoring" {
  description = "monitoring"
  type        = string
  default     = ""
}

# variable "ec2_server_key_name" {
#   description = "Description"
#   type        = string
#   default     = ""
# }

variable "ec2_server_instance_type" {
  description = "instance_type"
  type        = string
  default     = "t3.medium"
}

variable "ec2_server_volume_a_size" {
  description = "volume_a_size"
  type        = string
  default     = ""
}

variable "ec2_server_volume_a_type" {
  description = "volume_a_type"
  type        = string
  default     = ""
}

# ami image id
variable "ec2_server_ami_image_id" {
  description = "ami_image_id"
  type        = string
  default     = ""
}

variable "ec2_server_aws_kms_key_id" {
  description = "aws_kms_key_id"
  type        = string
  default     = ""
}

# ALB SG ID

variable "ec2_server_alb_sg_id" {
  description = "alb_sg_id"
  type        = string
  default     = ""
}

# TG

variable "ec2_server_tg_protocol" {
  description = "tg_protocol"
  type        = string
  default     = "HTTP"
}

variable "ec2_server_tg_port" {
  description = "tg_port"
  type        = string
  default     = ""
}

variable "ec2_server_tg_health_check" {
  description = "tg_health_check"
  type        = string
  default     = ""
}

variable "ec2_server_asg_min_size" {
  description = "asg_min_size"
  type        = number
  default     = 0
}

variable "ec2_server_asg_max_size" {
  description = "asg_max_size"
  type        = number
  default     = 0
}

variable "ec2_server_asg_desired_capacity" {
  description = "asg_desired_capacity"
  type        = number
  default     = 0
}

variable "ec2_server_codedeploy_tags" {
  description = "codedeploy_tags"
  type        = map(string)
  default     = null
}

variable "common_tags" {
  description = "common_tags"
  type        = map(string)
  default     = null
}

