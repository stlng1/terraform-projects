#############################
##creating bucket for s3 backend
#########################

resource "aws_s3_bucket" "terraform_state" {
  bucket = "femmy-dev-terraform-bucket"
 
  # Prevent accidental deletion of this S3 bucket
  lifecycle {
    prevent_destroy = true
  }
}
# resource "aws_s3_bucket" "terraform_state" {
#   bucket        = "femmy-dev-terraform-bucket"
#   force_destroy = true
# }

resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# resource "aws_s3_bucket_versioning" "version" {
#   bucket = aws_s3_bucket.terraform-state.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }

resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# resource "aws_s3_bucket_server_side_encryption_configuration" "first" {
#   bucket = aws_s3_bucket.terraform-state.id
#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = "AES256"
#     }
#   }
# }

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}



/*# Backend must remain commented until the Bucket
 and the DynamoDB table are created. 
 After the creation you can uncomment it,
 run "terraform init" and then "terraform apply" */

# terraform {
#   backend "s3" {
#     bucket         = "femmy-dev-terraform-bucket"
#     key            = "global/s3/terraform.tfstate"
#     region         = "eu-west-3"
#     dynamodb_table = "terraform-locks"
#     encrypt        = true
#   }
# }