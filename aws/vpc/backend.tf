terraform {
  backend "s3" {
    bucket = "mend-state-739929374881"
    region = "eu-north-1"
    key    = "vpc/terraform.tfstate"
    dynamodb_table = "tf-state-lock-739929374881"
    profile = "mend"
  }
}
