# Create S3 bucket
resource "aws_s3_bucket" "week7-s3Bucket" {
  bucket = "ece592-week7-skaggsc"
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    enabled = true
    id      = "DeleteAfter30Days"
    expiration {
      days = 30
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.week7-kmsKey.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

# Create S3 bucket notification
resource "aws_s3_bucket_notification" "week7-S3BucketNotification" {
    bucket = aws_s3_bucket.week7-s3Bucket.id
    lambda_function {
        lambda_function_arn = aws_lambda_function.lambda.arn
        events = ["s3:ObjectCreated:*"]
    }
}

# Create lambda permission
resource "aws_lambda_permission" "week7-lambdaPermission" {
    action = "lambda:InvokeFunction"
    principal = "s3.amazonaws.com"
    function_name = aws_lambda_function.lambda.arn
}
