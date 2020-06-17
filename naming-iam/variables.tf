variable "oe" {
  default     = "aztec"
  description = "Allianz OE with the typical accronym, e.g. 'azt' for Allianz Technology"
}

variable "project" {
  default     = ""
  description = "Project name if projects has it's own environment"
}

variable "context" {
  default     = "cloudtribe"
  description = "Environment to deploy resources, e.g. 'prod', 'test', 'dev', or 'shared'"
}

variable "policy" {
  default = ""
  description = "Policyname or easy e.g. 'policy'"
}

variable "role" {
  default = ""
  description = "Role of an IAM role e.g. assumerole"
}

variable "groupname" {
  description = "used for Groups - use the group name e.g. infraadmin"
}

#variable "ext" {
#  description = "extension to the full name, e.g. Sequenze or additional name"
#  default     = ""
#}

variable "enabled" {
  description = "Set to false to prevent the module from creating any resources"
  default     = "true"
}

variable "delimiter" {
  type        = "string"
  default     = "-"
  description = "Delimiter to be used between `name`, `namespace`, `stage`, etc."
}

variable "attributes" {
  type        = "list"
  default     = []
  description = "Additional attributes (e.g. `policy` or `role`)"
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit`,`XYZ`)"
}
