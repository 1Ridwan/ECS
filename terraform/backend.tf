terraform {
  backend "s3" {
    bucket         = "terraform-state-ridwan-ecs"
    key            = "terraform.tfstate"
    region         = "eu-west-2"
  }
}

# TODO: enable native state locking