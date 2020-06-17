output "id-policy" {
  value       = "${null_resource.default.triggers.id-policy}"
  description = "Policy-ID"
}

output "id-role" {
  value       = "${null_resource.default.triggers.id-role}"
  description = "Policy-ID"
}

output "id-groupname" {
  value       = "${null_resource.default.triggers.id-groupname}"
  description = "Policy-ID"
}

output "oe" {
  value       = "${null_resource.default.triggers.oe}"
  description = "Normalized OE"
}

output "project" {
  value       = "${null_resource.default.triggers.project}"
  description = "Normalized project name"
}

output "policy" {
  value       = "${null_resource.default.triggers.policy}"
  description = "Normalized policy"
}

output "role" {
  value       = "${null_resource.default.triggers.role}"
  description = "Normalized role name"
}

output "groupname" {
  value       = "${null_resource.default.triggers.groupname}"
  description = "Normalized groupname"
}

output "attributes" {
  value       = "${null_resource.default.triggers.attributes}"
  description = "Normalized attributes"
}

# Merge input tags with our tags.
# Note: `Name` has a special meaning in AWS and we need to disamgiuate it by using the computed `id`
output "tags-policy" {
  value = "${
      merge( 
        map(
          "Name", "${null_resource.default.triggers.id-policy}",
	      "OE", "${null_resource.default.triggers.oe}",
	      "Project", "${null_resource.default.triggers.project}",
	      "Region", "${data.aws_region.current.name}"
        ), var.tags
      )
    }"
  description = "Normalized Tag map for policy"
}

output "tags-role" {
  value = "${
      merge(
        map(
          "Name", "${null_resource.default.triggers.id-role}",
	      "OE", "${null_resource.default.triggers.oe}",
	      "Project", "${null_resource.default.triggers.project}",
	      "Region", "${data.aws_region.current.name}"
        ), var.tags
      )
    }"
  description = "Normalized Tag map for role"
}

output "tags-groupname" {
  value = "${
      merge(
        map(
          "Name", "${null_resource.default.triggers.id-groupname}",
	      "OE", "${null_resource.default.triggers.oe}",
	      "Project", "${null_resource.default.triggers.project}",
	      "Region", "${data.aws_region.current.name}"
        ), var.tags
      )
    }"
  description = "Normalized Tag map for groupname"
}

