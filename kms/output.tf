# KMS Outputs
output "key_id" {
  value = "${aws_kms_key.key.id}"
}

output "key_arn" {
  value = "${aws_kms_key.key.arn}"
}
