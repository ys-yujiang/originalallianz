infra_project_name = "infra"

environment_name = "sh"

region = "eu-central-1"

main_vpccidr = "10.xxxx/24"

default_outbound_ip_range = "0.0.0.0/0"

internal_ip_range = "10.0.0.0/8"

subnet_az_a = "eu-central-1a"

subnet_az_b = "eu-central-1b"

subnet_public_external_cidr_a = "10.xx/26"

subnet_public_internal_cidr_a = "10.xxx/27"

subnet_private_cidr_a = "10.xxx/27"

subnet_public_external_cidr_b = "10.xx/26"

subnet_public_internal_cidr_b = "10.xxx/27"

subnet_private_cidr_b = "10.xxx/27"

//TODO Extract this in assume role
iam_assume_role_resource = "arn:aws:iam::xxx:root"

rt_igw_routes = ["0.0.0.0/0"]

rt_private_nat_routes = ["0.0.0.0/0"]

virtual_gw_id = "vgw-xxxx"

rt_vgw_routes = ["10.0.0.0/8", "xxx/12", "xxx/16"]

# Description: Parameters file for jenkins
jenkins_asg_min = 1

jenkins_asg_max = 1

jenkins_asg_capacity = 1

jenkins_asg_health_check_grace_period = 300

jenkins_project_name = "jenkins"

jenkins_lc_name_prefix = "jenkins_lc"

//TODO: Fix this ami id
jenkins_lc_image_id = "ami-blabla"

jenkins_lc_instance_type = "m4.large"

# Description Parameters for Description

dns_instance_type = "t2.medium"

dns_vpc_dnsip = "xxx"

dns_onprem_domain = "xxx"

dns_onprem_dnsip = "xxx"

#dns_ip_shared_a = "10....."
#dns_ip_shared_b = "10....."



# Description : Parameters for the Concourse box

concourse_lc_instance_type = "m4.large"

concourse_lc_name_prefix = "concourse_lc"

concourse_asg_max = 1

concourse_asg_min = 1

concourse_asg_capacity = 1

r53_dns_private_zone_name = "xxx"
