

# Check if policy, function or groupname is available
locals {
  ext_temp = "${var.policy != "" ? var.policy : ""}"
  ext = "${local.ext_temp == "" && var.role != "" ? var.role : var.groupname}"
}

data "aws_region" "current" {
}

resource "null_resource" "default" {
  count = "${var.enabled == "true" ? 1 : 0}"

  triggers = {
    id-policy          = "${lower(join(var.delimiter, compact(concat(list(var.oe, var.context,  var.project, var.policy), var.attributes))))}"
    id-role          = "${lower(join(var.delimiter, compact(concat(list(var.oe, var.context,  var.project, var.role), var.attributes))))}"
    id-groupname          = "${lower(join(var.delimiter, compact(concat(list(var.oe, var.context,  var.project, var.groupname), var.attributes))))}"
    oe          = "${lower(format("%v", var.oe))}"
    project     = "${lower(format("%v", var.project))}"
    context = "${lower(format("%v", var.context))}"
    policy     = "${lower(format("%v", var.policy))}"
    role    = "${lower(format("%v", var.role))}"
    groupname        = "${lower(format("%v", var.groupname))}"
    attributes  = "${lower(format("%v", join(var.delimiter, compact(var.attributes))))}"
  }

  lifecycle {
    create_before_destroy = true
  }
}
