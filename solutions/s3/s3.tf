module "central_iam_s3_bucket" {
  source = "../tf_modules/s3"
  s3_bucket_name = "s3-infra-ec1-sh-tfstate-02"
  project = "infra"
  environment = "sh"
  region = "${var.region}"
  service = "s3"
  role = "tfstate"
  ext = "02"
}