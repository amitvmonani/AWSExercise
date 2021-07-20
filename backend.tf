/*terraform {
  backend "s3" {
    bucket = "terraform-state-amitvmonani"
    key = "myapp/terraform.tfstate"
    region = "eu-west-2"
   }
}

terraform {
    backend "s3" {
        bucket = "{your-bucket-name}"
        dynamodb_table = "terraform-statelock-dynamodb" # This is the new key
        encrypt = true
        key = "path/to/state/state.tfstate"
        region = "eu-west-2"
    }
}*/