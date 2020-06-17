/* ====================================================
## Terraform script to create a EBS volume
## =================================================== */

resource "aws_ebs_volume" "volume" {
  availability_zone = "${var.ebs_availability_zone}"
  size              = "${ var.ebs_volume_size_gb }"
  encrypted         = "${var.encrypted}"
  iops              = "${var.ebs_iops}"
  snapshot_id       = "${var.snapshot_id}"
  type              = "${var.ebs_type}"
  tags              = "${module.label.tags}"
}
