resource "github_repository" "repo" {
  name = var.repository_name
  description = "Github repo for use with Terraform"
}
