data "aws_iam_policy" "apprunner_ecr_access" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSAppRunnerServicePolicyForECRAccess"
}

resource "aws_iam_role" "apprunner_ecr_access" {
  name               = "Test-AppRunnerECRAccessRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "build.apprunner.amazonaws.com" },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "apprunner_ecr_access_attach" {
  role       = aws_iam_role.apprunner_ecr_access.name
  policy_arn = data.aws_iam_policy.apprunner_ecr_access.arn
}

resource "aws_apprunner_service" "example" {
  service_name = "example"
  health_check_configuration {
    protocol            = "HTTP"
    path                = "/"
    healthy_threshold   = 1
    unhealthy_threshold = 5
    interval            = 10
    timeout             = 5
  }
  source_configuration {
    authentication_configuration {
      access_role_arn = aws_iam_role.apprunner_ecr_access.arn
    }
    image_repository {
      image_configuration {
        port = "3000"
      }
      image_identifier      = var.repository_url
      image_repository_type = "ECR"
    }
    auto_deployments_enabled = true
  }

  tags = {
    Name = "example-apprunner-service"
  }
}
