## Setup VPC and DNS/DHCP Options

Notice that all arguments are optional but you have to specify at least one argument.
domain_name_servers, netbios_name_servers, ntp_servers are limited by AWS to maximum four servers only.
To actually use the DHCP Options Set you need to associate it to a VPC using aws_vpc_dhcp_options_association.
If you delete a DHCP Options Set, all VPCs using it will be associated to AWS's default DHCP Option Set.
In most cases unless you're configuring your own DNS you'll want to set domain_name_servers to AmazonProvidedDNS.