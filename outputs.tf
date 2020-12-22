output "github_repo_clone_url_ssh" {
  value = module.github.github_repo_clone_url_ssh
}
output "s3_website_bucket_endpoint" {
  value = module.s3.s3_website_bucket_endpoint
}
output "codepipeline_pipeline_name" {
  value = module.codepipeline.pipeline_name
}
