locals {
  // user_data = <<-EOT
  //   #!/bin/bash
  // EOT
  ip_secret = data.aws_secretsmanager_secret_version.current.secret_string
}