data "template_file" "codepipeline_role" {
  template = file("${path.module}/codepipeline_role.json")
}

data "template_file" "codepipeline_policy" {
  template = file("${path.module}/codepipeline_policy.json")
}

# Build S3 bucket for CodePipeline artifact storage
resource "aws_s3_bucket" "codepipeline_artifact_bucket" {
  bucket = var.codepipeline_artifact_bucket_name
  acl    = "private"
  force_destroy = true
  lifecycle {
    prevent_destroy = false
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_iam_role" "codepipeline_role" {
  name = var.codepipeline_role_name
  assume_role_policy = data.template_file.codepipeline_role.rendered
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name = var.codepipeline_role_policy_name
  role = aws_iam_role.codepipeline_role.id
  policy = data.template_file.codepipeline_policy.rendered
}

resource "aws_codepipeline" "codepipeline" {
  name     = var.codepipeline_name
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_artifact_bucket.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["SourceArtifact"]

      configuration = {
        RepositoryName = var.codecommit_repo_name
        BranchName     = "master"
      }
    }
  }

  stage {
    name = "Test"

    action {
      name             = "Test"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["SourceArtifact"]
      version          = "1"

      configuration = {
        ProjectName = var.codebuild_test_name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      input_artifacts = ["SourceArtifact"]
      output_artifacts = ["OutputArtifact"]
      version         = "1"

      configuration = {
        ProjectName = var.codebuild_build_name
      }
    }
  }
}
