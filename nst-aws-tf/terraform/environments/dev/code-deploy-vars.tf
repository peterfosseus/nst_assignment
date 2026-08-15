
locals {
  app = {
    name            = "api"
    app_secret_name = "nst-rewards-dev"
  }
}

locals {
  codedeploy = {
    application = {
      name = "${var.company_name}-${var.service}-${var.env_name}-application"
    }
    deployment_group = {
      name = "${var.company_name}-${var.service}-${var.env_name}-deployment-group"
    }
    ec2_tag_filter = {
      key   = "app"
      type  = "KEY_AND_VALUE"
      value = local.app.name
    }
    auto_rollback_configuration = {
      enabled = true
      events  = "DEPLOYMENT_FAILURE"
    }
    alarm_configuration = {
      alarms  = "deploy-alarm"
      enabled = true
    }
    s3 = {
      bucket_folder = "${var.company_name}-${var.service}-${var.env_name}-code"
    }
    outdated_instances_strategy = "UPDATE"
  }
}
