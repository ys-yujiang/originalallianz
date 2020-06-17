# ====================================
# Outputs for Launch configuration module
# ====================================*/
output "lc_id" {
  value = "${aws_launch_configuration.lc.id}"
}

output "lc_name" {
  value = "${aws_launch_configuration.lc.name}"
}
