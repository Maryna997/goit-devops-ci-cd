terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket-30062026113045"
    key            = "terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
    use_lockfile   = true
  }
}