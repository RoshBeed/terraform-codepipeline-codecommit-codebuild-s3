data "template_file" "codebuild_iam_role" {
  template = file("${path.module}/codebuild_iam_role.json")
}

resource "aws_iam_role" "codebuild_iam_role" {
  name = var.codebuild_iam_role_name
  assume_role_policy = data.template_file.codebuild_iam_role.rendered
}

data "template_file" "codebuild_iam_role_policy" {
  template = file("${path.module}/codebuild_iam_role_policy.json")
  vars  = {
      codepipeline_artifact_bucket_arn = var.codepipeline_artifact_bucket_arn
      codecommit_repo_arn = var.codecommit_repo_arn
      s3_website_bucket_arn = var.s3_website_bucket_arn
      codebuild_iam_role_arn = aws_iam_role.codebuild_iam_role.arn
    }
}

resource "aws_iam_role_policy" "codebuild_iam_role_policy" {
  name = var.codebuild_iam_role_policy_name
  role = aws_iam_role.codebuild_iam_role.name
  policy = data.template_file.codebuild_iam_role_policy.rendered
}

resource "aws_codebuild_project" "codebuild_project_test" {
  name          = var.codebuild_project_test_name
  description   = "Terraform codebuild project"
  build_timeout = "5"
  service_role  = aws_iam_role.codebuild_iam_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "S3_WEBSITE_BUCKET"
      value = var.s3_website_bucket
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "log-group"
      stream_name = "log-stream"
    }
  }
  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec_test.yml"
  }

  tags = {
    Terraform = "true"
  }
}

resource "aws_codebuild_project" "codebuild_project_build" {
  name          = var.codebuild_project_build_name
  description   = "Terraform codebuild project"
  build_timeout = "5"
  service_role  = aws_iam_role.codebuild_iam_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

  environment_variable {
      name  = "S3_WEBSITE_BUCKET"
      value = var.s3_website_bucket
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "log-group"
      stream_name = "log-stream"
    }
  }
  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec_build.yml"
  }

  tags = {
    Terraform = "true"
  }
}
