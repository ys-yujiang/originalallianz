module "aztec-cloudtribe-readonly-assumerole" {
  source                  = "../tf_modules/iam/role"
  iam_rolename            = "aztec-cloudtribe-readonly-assumerole"
  default_path            = "${path.cwd}/policies"
  role_iam_policy_arn     = ["arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"]
  assume_role_policy_name = "${var.iam_policy_filename}"
}

module "aztec-cloudtribe-platformadmin-assumerole" {
  source       = "../tf_modules/iam/role"
  iam_rolename = "aztec-cloudtribe-platformadmin-assumerole"
  default_path = "${path.cwd}/policies"

  role_iam_policy_arn = ["arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws:iam::aws:policy/AmazonVPCFullAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
  ]

  attached_policy_count   = "3"
  assume_role_policy_name = "${var.iam_policy_filename}"
}

module "aztec-cloudtribe-iamadmin-assumerole" {
  source                  = "../tf_modules/iam/role"
  iam_rolename            = "aztec-cloudtribe-iamadmin-assumerole"
  default_path            = "${path.cwd}/policies"
  role_iam_policy_arn     = ["arn:aws:iam::aws:policy/IAMFullAccess"]
  assume_role_policy_name = "${var.iam_policy_filename}"
}

module "aztec-cloudtribe-networkadmin-assumerole" {
  source                  = "../tf_modules/iam/role"
  iam_rolename            = "aztec-cloudtribe-networkadmin-assumerole"
  default_path            = "${path.cwd}/policies"
  role_iam_policy_arn     = ["${module.aztec-cloudtribe-networkadmins-policy.iam_policy_arn}"]
  assume_role_policy_name = "${var.iam_policy_filename}"
}

module "aztec-cloudtribe-infraadmin-assumerole" {
  source                  = "../tf_modules/iam/role"
  iam_rolename            = "aztec-cloudtribe-infraadmin-assumerole"
  default_path            = "${path.cwd}/policies"
  role_iam_policy_arn     = ["${module.aztec-cloudtribe-infraadmins-policy.iam_policy_arn}"]
  assume_role_policy_name = "${var.iam_policy_filename}"

}

module "aztec-cloudtribe-securityadmin-assumerole" {
  source                  = "../tf_modules/iam/role"
  iam_rolename            = "aztec-cloudtribe-securityadmin-assumerole"
  default_path            = "${path.cwd}/policies"
  role_iam_policy_arn     = ["${module.aztec-cloudtribe-securityadmins-policy.iam_policy_arn}"]
  assume_role_policy_name = "${var.iam_policy_filename}"

}
