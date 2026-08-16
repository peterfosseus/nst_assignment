
locals {
  alb = {
    name = "${var.company_name}-${var.env_name}-alb"
    target_group = {
      name = "${var.company_name}-${var.env_name}-tg"
    }
    bucket = {
      access_log = {
        name   = "${var.company_name}-${var.env_name}-alb-access-log"
        prefix = "${var.company_name}-${var.env_name}"
        tags = {
          name = "${var.company_name}-${var.env_name}-alb-access-log"
        }
      }
      connection_log = {
        name   = "${var.company_name}-${var.env_name}-alb-connection-log"
        prefix = "${var.company_name}-${var.env_name}"
        tags = {
          name = "${var.company_name}-${var.env_name}-alb-connection-log"
        }
      }
    }
    tags = {
      Name = "${var.company_name}-${var.env_name}-nlb"
    }
  }
}
