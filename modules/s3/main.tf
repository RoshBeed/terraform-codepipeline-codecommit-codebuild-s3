resource "aws_s3_bucket" "s3_website_bucket" {

    bucket =  var.s3_website_bucket
    acl    = "public-read"
    force_destroy = true
  
    lifecycle {
      prevent_destroy = false
    }
    
    cors_rule {
        allowed_headers = ["*"]
        allowed_methods = ["PUT", "POST", "GET", "DELETE"]
        allowed_origins = ["*"]
        expose_headers  = ["ETag"]
        max_age_seconds = 3000
    }

    website {
        index_document = "index.html"
        error_document = "index.html"
    }
}

data "template_file" "s3_bucket_site_policy" {
  template = "${file("${path.module}/s3_website_bucket_policy.json")}"
  vars  = {
      s3_website_bucket = "${var.s3_website_bucket}"
      arn = "${aws_s3_bucket.s3_website_bucket.arn}"
    }
}

resource "aws_s3_bucket_policy" "s3_bucket_site_policy" {
    bucket = "${aws_s3_bucket.s3_website_bucket.id}"
    policy = "${data.template_file.s3_bucket_site_policy.rendered}"
}
