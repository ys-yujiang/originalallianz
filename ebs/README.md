##EBS

Purpose of this module is to create EBS volume.

####Available options

* ebs_availability_zone(e.g. eu-west-1a)
* ebs_volume_size_gb(e.g. 20GB)
* encrypted(e.g. true or false - default is true)
* ebs_iops(e.g. number of iops for disk: 3000)
* snapshot_id" by default is ""
* ebs_type:
  Can be "standard", "gp2", "io1", "sc1" or "st1" (Default: "standard").

 
For more information: https://www.terraform.io/docs/providers/aws/r/ebs_volume.html