terraform {
  backend "s3" {
    bucket = "my-blog-terraform"
    key    = "terraform.tfstate"
    region = "us-east-2"
  }
}
