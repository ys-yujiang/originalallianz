output "bucket-name" {
  value = "${aws_s3_bucket.tfstate.id}"
}

output "bucket-arn" {
  value = "${aws_s3_bucket.tfstate.arn}"
}
