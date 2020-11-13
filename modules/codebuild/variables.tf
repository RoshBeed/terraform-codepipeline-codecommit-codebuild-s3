variable "codebuild_project_test_name" {
  description = "Name for CodeBuild test Project"
}
variable "codebuild_project_build_name" {
  description = "Name for CodeBuild build Project"
}
variable "codebuild_iam_role_name" {
  description = "Name for IAM Role utilized by CodeBuild"
}
variable "codebuild_iam_role_policy_name" {
  description = "Name for IAM policy used by CodeBuild"
}
variable "codecommit_repo_arn" {
  description = "Terraform CodeCommit git repo ARN"
}
variable "codepipeline_artifact_bucket_arn" {
  description = "Codepipeline artifact bucket ARN"
}
variable "s3_website_bucket" {
  description = "Name of the S3 bucket for website"
}
variable "s3_website_bucket_arn" {
  description = "s3 website bucket"
}
