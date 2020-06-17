# Description:
resource "aws_ssm_document" "foo" {
  name          = "${var.document_name}"
  document_type = "${var.document_type}"

  content = "${var.document_content}"
}