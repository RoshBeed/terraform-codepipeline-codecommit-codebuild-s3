variable "codepipeline_artifact_bucket_name" {
  description = "Name of the TF CodePipeline S3 bucket for artifacts"
}
variable "codepipeline_role_name" {
  description = "Name of the Terraform CodePipeline IAM Role"
}
variable "codepipeline_role_policy_name" {
  description = "Name of the Terraform IAM Role Policy"
}
variable "codepipeline_name" {
  description = "CodePipeline Name"
}
variable "codecommit_repo_name" {
  description = "CodeCommit repo name"
}
variable "codebuild_test_name" {
  description = "Test codebuild project name"
}
variable "codebuild_build_name" {
  description = "Build codebuild project name"
}
