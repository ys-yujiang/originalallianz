/* ====================================
## Output definition for isntance profile
##
## Author:
## Date:
##
## ====================================*/

output "instance_profile_arn" {
  value = "${aws_iam_instance_profile.iam_instance_profile.arn}"
}
