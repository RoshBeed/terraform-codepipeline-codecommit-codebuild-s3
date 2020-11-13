output "codecommit_repo_arn" {
  value = aws_codecommit_repository.repo.arn
}
output "codecommit_repo_name" {
  value = var.repository_name
}
output "codecommit_repo_clone_url_ssh" {
  value = aws_codecommit_repository.repo.clone_url_ssh
}
