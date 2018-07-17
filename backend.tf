terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "stone-terraform-remote-state-storage-s3"
    dynamodb_table = "terraform-state-lock-dynamo"
    region         = "us-east-1"
    key            = "terraform.tfstate"
  }
}

resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name           = "terraform-state-lock-dynamo"
  hash_key       = "LockID"
  read_capacity  = 6
  write_capacity = 6

  attribute {
    name = "LockID"
    type = "S"
  }

  tags {
    Name = "DynamoDB Terraform State Lock Table"
  }
}
