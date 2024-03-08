resource "aws_s3_bucket" "Terra-Bucket" {
  bucket = "terraform-bucket-2024"
}

resource "null_resource" "Terra-S3-Folder" {
  provisioner "local-exec" {
    command     = "aws s3api put-object --bucket ${aws_s3_bucket.Terra-Bucket.bucket} --key Terra-State/"
    interpreter = ["PowerShell", "-Command"]
  }
  depends_on = [aws_s3_bucket.Terra-Bucket]
}
