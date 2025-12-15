output "bucket_names" {
  description = "Map of S3 bucket names keyed by the provided identifier."
  value       = { for key, bucket in aws_s3_bucket.tf_backend : key => bucket.bucket }
}

output "dynamodb_lock_table_name" {
  description = "Name of the DynamoDB lock table (null when not created)."
  value       = length(aws_dynamodb_table.tf_lock) > 0 ? aws_dynamodb_table.tf_lock[0].name : null
}
