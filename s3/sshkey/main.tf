locals {
  public_key_filename  = "${var.ssh_public_key_path}/${module.label.id}${var.public_key_extension}"
  private_key_filename = "${var.ssh_public_key_path}/${module.label.id}${var.private_key_extension}"
}

resource "aws_s3_bucket_object" "publickey" {
  bucket = "s3-infra-ec1-sh-tfstate-02"

  #  bucket = "s3-bootstrap-ec1-shared-tfstate-01"
  key    = "cloudtribe/shared/sshkey/${module.label.id}${var.public_key_extension}"
  source = "${local.public_key_filename}"

  #  etag   = "${md5(file("${local.public_key_filename}"))}"
}

resource "aws_s3_bucket_object" "privatekey" {
  bucket = "s3-infra-ec1-sh-tfstate-02"

  #  bucket = "s3-bootstrap-ec1-shared-tfstate-01"
  key    = "cloudtribe/shared/sshkey/${module.label.id}${var.private_key_extension}"
  source = "${local.private_key_filename}"

  #  etag   = "${md5(file("${local.private_key_filename}"))}"
}

resource "aws_key_pair" "imported" {
  count      = "${var.generate_ssh_key == "false" ? 1 : 0}"
  key_name   = "${module.label.id}"
  public_key = "${file("${local.public_key_filename}")}"
}

resource "tls_private_key" "default" {
  count     = "${var.generate_ssh_key == "true" ? 1 : 0}"
  algorithm = "${var.ssh_key_algorithm}"
}

resource "aws_key_pair" "generated" {
  count      = "${var.generate_ssh_key == "true" ? 1 : 0}"
  depends_on = ["tls_private_key.default"]
  key_name   = "${module.label.id}"
  public_key = "${tls_private_key.default.public_key_openssh}"
}

resource "local_file" "public_key_openssh" {
  count      = "${var.generate_ssh_key == "true" ? 1 : 0}"
  depends_on = ["tls_private_key.default"]
  content    = "${tls_private_key.default.public_key_openssh}"
  filename   = "${local.public_key_filename}"
}

resource "local_file" "private_key_pem" {
  count      = "${var.generate_ssh_key == "true" ? 1 : 0}"
  depends_on = ["tls_private_key.default"]
  content    = "${tls_private_key.default.private_key_pem}"
  filename   = "${local.private_key_filename}"
}

resource "null_resource" "chmod" {
  count      = "${var.generate_ssh_key == "true" ? 1 : 0}"
  depends_on = ["local_file.private_key_pem"]

  provisioner "local-exec" {
    command = "chmod 600 ${local.private_key_filename}"
  }
}
