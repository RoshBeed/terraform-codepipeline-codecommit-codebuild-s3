terraform {
  required_version = ">=0.12.16"
}

provider "aws" {
  region  = "us-east-1"
  version = "~> 2.36.0"
}

module "s3" {
  source            = "./modules/s3"
  s3_website_bucket = "${var.project_name}-website"
}

module "codecommit" {
  source          = "./modules/codecommit"
  repository_name = "${var.project_name}-CodeCommit"
}

module "codebuild" {
  source                           = "./modules/codebuild"
  codebuild_project_test_name      = "${var.project_name}-test"
  codebuild_project_build_name     = "${var.project_name}-build"
  codebuild_iam_role_name          = "${var.project_name}-CodeBuildIamRole"
  codebuild_iam_role_policy_name   = "${var.project_name}-CodeBuildIamRolePolicy"
  s3_website_bucket                = module.s3.s3_website_bucket
  s3_website_bucket_arn            = module.s3.s3_website_bucket_arn
  codecommit_repo_arn              = module.codecommit.codecommit_repo_arn
  codepipeline_artifact_bucket_arn = module.codepipeline.codepipeline_artifact_bucket_arn
}

module "codepipeline" {
  source                            = "./modules/codepipeline"
  codepipeline_name                 = "${var.project_name}-CodePipeline"
  codepipeline_artifact_bucket_name = "${var.project_name}-codebuild-demo-artifact-bucket-name"
  codepipeline_role_name            = "${var.project_name}-CodePipelineIamRole"
  codepipeline_role_policy_name     = "${var.project_name}-CodePipelineIamRolePolicy"
  codecommit_repo_name              = module.codecommit.codecommit_repo_name
  codebuild_test_name               = module.codebuild.codebuild_test_name
  codebuild_build_name              = module.codebuild.codebuild_build_name
}
