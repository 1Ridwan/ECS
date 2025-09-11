terraform {
  backend "s3" {
    bucket         = "terraform-state-ridwan-ecs"
    key            = "terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

# need to add dynamodb table as i think the reason this works is bc its connecting one ive initialised before