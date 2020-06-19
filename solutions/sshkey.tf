# Create SSH - Key based on parameter
# Author: Werner Brandt

# TODO: This needs to be adapted so that the ssh key is stored in s3 whilst vault is not available.

variable "relative_pathname" {
  description = " relative path from current working directory to ssh key pair"
  default     = ""
}

variable "project_name" {
  default = ""
}

module "sshkey" {
  source                = "../tf_modules/sshkey"
  generate_ssh_key      = "true"
  private_key_extension = ".id"
  ssh_public_key_path   = "${path.cwd}"

  #Naming variables
  service     = "ec2"
  project     = "${var.infra_project_name}"
  environment = "${var.environment_name}"
  role        = "bastion-sshkey"
  ext         = ""
}

output "key_name" {
  value = "${module.sshkey.key_name}"
}

output "public_key" {
  value = "${module.sshkey.public_key}"
}
