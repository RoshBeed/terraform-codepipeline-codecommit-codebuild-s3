output "pipeline_name" {
  value = var.codepipeline_name
}
output "codepipeline_artifact_bucket_arn" {
  value = aws_s3_bucket.codepipeline_artifact_bucket.arn
}
