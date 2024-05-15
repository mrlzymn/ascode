terraform {
  backend "s3" {
    bucket         = "YOUR_BUCKET_NAME"
    key            = "YOUR_KEY_HERE/fsx-windows.tfstate"
    region         = "REGION_FOR_REMOTE_BACKEN_HERE"
    dynamodb_table = "terraform-state-lock"
  }
}