## Setup VPC and DNS/DHCP Options

The variables are:

```
variable "vpc-fullcidr" {
    default = "172.28.0.0/16"
  description = "the vpc cdir"
}
variable "tagName" {
  default = ""
  description = "Set the Tag Name"
}
variable "DnsZoneName" {
  default = "temp.aztec.cloud.allianz"
  description = "the internal dns name"
}

```


Output:
```
output "vpcid" {
  value = "${aws_vpc.terraformmain.id}"
}

output "DNSZoneID" {
  value = "${aws_route53_zone.main.zone_id}"
}
```
