terraform {
  backend "s3" {
    bucket         = "lesson-7-state"
    key            = "lesson-7/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
    use_lockfile   = true
  }
}
