provider "aws" {
  region  = var.region
  profile = "mend"
}

resource "aws_s3_bucket" "tf_backend" {
  for_each      = var.buckets
  bucket        = "${each.value.bucket_name_prefix}-${local.account_id}"
  force_destroy = true

  tags = merge({
    Name        = "Terraform State Bucket"
    Environment = each.value.environment
  }, try(each.value.tags, {}))
}

resource "aws_dynamodb_table" "tf_lock" {
  count        = var.enable_dynamodb_lock_table ? 1 : 0
  name         = coalesce(var.dynamodb_lock_table_name, "tf-state-lock-${local.account_id}")
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = merge({
    Name        = "Terraform State Lock Table"
    Environment = try(values(var.buckets)[0].environment, "shared")
  }, try(values(var.buckets)[0].tags, {}))
}

resource "aws_s3_bucket_versioning" "versioning" {
  for_each = aws_s3_bucket.tf_backend

  bucket = each.value.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
  for_each = aws_s3_bucket.tf_backend

  bucket = each.value.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  for_each                = aws_s3_bucket.tf_backend
  bucket                  = each.value.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
