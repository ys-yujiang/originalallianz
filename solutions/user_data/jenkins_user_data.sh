#!/usr/bin/env bash
# Description: User data script for Jenkins
#  The user data defines what the behaviour of the Jenkins should be when responding to an Auto scaling event.



// main config stuff goes in  /etc/bind


// avoid dns amplification attacks


// zone "aws.aztec.cloud.allianz" in {
      type forward;
      forwarders { 10.250.103.2};
}

add to file named.conf.options

!
acl goodclients {
    192.0.2.0/24;
    localhost;
    localnets;
};
!

options {
    directory "/var/cache/bind";

  ! recursion yes;
  ! allow-query { goodclients; };

  !  forwarders {
   !             8.8.8.8;
    !            8.8.4.4;
     !   };

  OK      dnssec-enable yes;
        dnssec-validation yes;
    
    !   dnssec-validation auto;

    !    auth-nxdomain no;    # conform to RFC1035
    !   listen-on-v6 { any; };
};


Test the configuration of bind:  named-checkconf
  