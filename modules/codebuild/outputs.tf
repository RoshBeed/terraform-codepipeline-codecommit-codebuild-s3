output "codebuild_test_name" {
  value = var.codebuild_project_test_name
}
output "codebuild_build_name" {
  value = var.codebuild_project_build_name
}
output "codebuild_iam_role_arn" {
  value = aws_iam_role.codebuild_iam_role.arn
}
