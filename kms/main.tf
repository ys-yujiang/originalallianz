# KMS Module
resource "aws_kms_key" "key" {
  description             = "${var.key_description}"
  enable_key_rotation = "${var.kms_enable_key_rotation}"
}
