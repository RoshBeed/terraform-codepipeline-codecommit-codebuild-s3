output "s3_website_bucket_endpoint" {
  value = aws_s3_bucket.s3_website_bucket.website_endpoint
}
output "s3_website_bucket_arn" {
  value = aws_s3_bucket.s3_website_bucket.arn
}
output "s3_website_bucket" {
  value = aws_s3_bucket.s3_website_bucket.bucket
}
