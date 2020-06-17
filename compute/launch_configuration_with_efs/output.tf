# ====================================
# Outputs for Launch configuration module
# ====================================*/
output "lc_id" {
  value = "${aws_launch_configuration.lc.id}"
}

output "efs_id" {
  value = "${aws_efs_file_system.default.id}"
}

output "efs_kms_key_id" {
  value = "${aws_efs_file_system.default.kms_key_id}"
}

output "efs_dns_name" {
  value = "${aws_efs_file_system.default.dns_name}"
}
