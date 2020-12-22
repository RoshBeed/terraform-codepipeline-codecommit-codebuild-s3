output "github_repo_name" {
  value = github_repository.repo.name
}
output "github_repo_clone_url_ssh" {
  value = github_repository.repo.ssh_clone_url
}
output "github_owner_name" {
  value = var.owner_name
}
