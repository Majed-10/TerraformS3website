#create S3 bucet to implement 



resource "aws_s3_bucket" "mybucket" {
  bucket = var.bucketname
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.mybucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# resource "aws_s3_bucket" "exam" {
#   bucket = "bucketname"
# }

# Use Case: This setup is suitable for scenarios where you need the bucket or its contents to be publicly available, such as hosting a public website or assets.
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.mybucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.example,
 ]

 ## u can put bucket public by this
  bucket = aws_s3_bucket.mybucket.id
  acl    = "public-read"
}


#to create page page of html
resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.mybucket.id
  key    = "index.html"
  source = "index.html"
  acl = "public-read"
  content_type = "text/html"



 
}
# to create error page 
resource "aws_s3_object" "err" {
  bucket = aws_s3_bucket.mybucket.id
  key    = "error.html"
  source = "error.html"
  acl = "public-read"
  content_type = "text/html"
}
#Use Case:

# This block is typically used to upload a file (like an image or document) to an S3 bucket. In this case, it uploads a profile.png file and makes it publicly accessible.
# resource "aws_s3_object" "profile"{
#     bucket = aws_s3_bucket.mybucket.id
#     key = "profile.png"
#     source = "profile.png"
#     acl = "public-read"

# }
# u can to 
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.mybucket.id
  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
  depends_on = [ aws_s3_bucket_acl.example]
}
