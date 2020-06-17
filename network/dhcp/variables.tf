variable "dhcp_domain_name" {
  default = ""
  description = "the suffix domain name to use by default when resolving non Fully Qualified Domain Names. In other words, this is what ends up being the search value in the /etc/resolv.conf file"
}

variable "dhcp_domain_name_servers" {
  type = "list"
  default = ["AmazonProvidedDNS"]
  description = "List of name servers to configure in /etc/resolv.conf. If you want to use the default AWS nameservers you should set this to AmazonProvidedDNS"
}

variable "dhcp_ntp_servers" {
  type = "list"
  default = []
  description = "List of NTP servers to configure"
}

variable "dhcp_netbios_name_servers" {
  type = "list"
  default = []
  description = "List of NETBIOS name servers"
}

variable "dhcp_netbios_node_type" {
  default = "2"
  description = "The NetBIOS node type (1, 2, 4, or 8). AWS recommends to specify 2 since broadcast and multicast are not supported in their network"
}

variable "dhcp_vpc_id" {
  description = "The ID of the VPC to which we would like to associate a DHCP Options Set"
}
