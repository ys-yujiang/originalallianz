module "aztec-cloudtribe-infraadmins-policy" {
  source          = "../tf_modules/iam/policy"
  iam_policy_name = "aztec-xxx-policy"
  default_path    = "${path.cwd}"
}

module "aztec-cloudtribe-securityadmins-policy" {
  source          = "../tf_modules/iam/policy"
  iam_policy_name = "aztec-xxx-policy"
  default_path    = "${path.cwd}"
}

module "aztec-cloudtribe-networkadmins-policy" {
  source          = "../tf_modules/iam/policy"
  iam_policy_name = "aztec-xxx-policy"
  default_path    = "${path.cwd}"
}
