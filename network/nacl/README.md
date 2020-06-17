# Module conains predefined Network ACLs

Currently available:
* Transfer Network ( Bastion Host etc.)
* OSE Network

## Input Parameter

| Name		| Default	| Desciption	| Required	|
|:--------------|:--------------|:--------------|:--------------|
| vpcid		| ""		| Id of the VPC | true	   	|
| create_mgmt_acl | true	| set to false if ACL for Managemet ACL should not be created |  |
| create host_acl | true	| set to false if ACL for Hosts Network should not be created |  |

## Output
| Name		| Description	|
|:--------------|:--------------|
| nacl-mgmt-id  | ID of the Management Network ACL |
| nacl-hosts-id | ID of the Host Network ACL |

## Settings

### Management NACL

| Direction | IP-Addresses | Ports | Description |
|:----------|:-------------|:------|:------------|
| egress    | 0.0.0.0/0    | all   | Allow all communications to other hosts |
| ingress   | 0.0.0.0/0    | TCP 22/ssh | Allow only ssh connection |


### Hosts ACL

| Direction | IP-Addresses | Ports | Description |
|:----------|:-------------|:------|:------------|
| egress    | 10.0.0.0/8 <br> 172.16.0.0/12 <br> 192.168.0.0./16    | all   | Allow only private IP-Addresses to other hosts |
| ingress   | 10.0.0.0/8 <br> 172.16.0.0/12 <br> 192.168.0.0./16    | all | Allow only private IP-Addresses |

## Notes
Dynamic definition of egress and ingress Rules can be found in Example
https://github.com/cloudposse/terraform-aws-named-subnets/blob/master/private.tf

