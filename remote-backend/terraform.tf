terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "terraform-state-ha"
    key            = "remote-backend/terraform.tfstate"
    region         = "eu-west-2"

    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}