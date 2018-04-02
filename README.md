# ec2zone.jq

This is a jq script that generates the body of a DNS zone for a set of ec2
instances, using ec2 api call output.

### How to use

``` sh
aws ec2 describe-instances | jq -r -f ec2zone.jq --arg zone yourzone.example.com
```

You'll need to add a header to the output before it will be a fully valid
DNS zone, with (at a minimum) a SOA record and one or more NS records.

### Example

```
$ aws ec2 describe-instances --region us-east-1 > instances.json

$ jq -r -f ec2zone.jq --arg zone herpderp.example.com < instances.json

$ORIGIN herpderp.example.com

; ip-172-21-26-143.ec2.internal
zk2.herpderp.example.com  IN A     172.21.26.143
zk2.herpderp.example.com  IN TXT   "id: i-240a21cb"
zk2.herpderp.example.com  IN HINFO "t2.micro"

; ip-172-21-2-12.ec2.internal
vagrant-mesos-slave2.herpderp.example.com  IN A     172.21.2.12
vagrant-mesos-slave2.herpderp.example.com  IN TXT   "id: i-60d5684c"
vagrant-mesos-slave2.herpderp.example.com  IN HINFO "m1.small"

; ip-172-21-12-209.ec2.internal
openvpn.herpderp.example.com  IN A     172.21.12.209
openvpn.herpderp.example.com  IN TXT   "id: i-ca764a25"
openvpn.herpderp.example.com  IN HINFO "t2.micro"

; ip-172-21-25-71.ec2.internal
chef-server1.herpderp.example.com  IN A     172.21.25.71
chef-server1.herpderp.example.com  IN TXT   "id: i-f8f770d4"
chef-server1.herpderp.example.com  IN HINFO "t2.micro"

; ip-172-21-3-11.ec2.internal
vagrant-mesos-marathon.herpderp.example.com  IN A     172.21.3.11
vagrant-mesos-marathon.herpderp.example.com  IN TXT   "id: i-acda6780"
vagrant-mesos-marathon.herpderp.example.com  IN HINFO "m1.small"

; ip-172-21-28-89.ec2.internal
zk3.herpderp.example.com  IN A     172.21.28.89
zk3.herpderp.example.com  IN TXT   "id: i-561f35b9"
zk3.herpderp.example.com  IN HINFO "t2.micro"

; ip-172-21-1-12.ec2.internal
vagrant-mesos-master2.herpderp.example.com  IN A     172.21.1.12
vagrant-mesos-master2.herpderp.example.com  IN TXT   "id: i-61d5684d"
vagrant-mesos-master2.herpderp.example.com  IN HINFO "m1.small"

; ip-172-21-1-11.ec2.internal
vagrant-mesos-master1.herpderp.example.com  IN A     172.21.1.11
vagrant-mesos-master1.herpderp.example.com  IN TXT   "id: i-99d469b5"
vagrant-mesos-master1.herpderp.example.com  IN HINFO "m1.small"

; ip-172-21-2-11.ec2.internal
vagrant-mesos-slave1.herpderp.example.com  IN A     172.21.2.11
vagrant-mesos-slave1.herpderp.example.com  IN TXT   "id: i-63d5684f"
vagrant-mesos-slave1.herpderp.example.com  IN HINFO "m1.small"

; ip-172-21-12-110.ec2.internal
NAT.herpderp.example.com  IN A     172.21.12.110
NAT.herpderp.example.com  IN TXT   "id: i-2ae86c06"
NAT.herpderp.example.com  IN HINFO "t1.micro"

; ip-172-21-0-11.ec2.internal
vagrant-mesos-zk1.herpderp.example.com  IN A     172.21.0.11
vagrant-mesos-zk1.herpderp.example.com  IN TXT   "id: i-05d46929"
vagrant-mesos-zk1.herpderp.example.com  IN HINFO "m1.small"

; ip-172-21-16-220.ec2.internal
zk1.herpderp.example.com  IN A     172.21.16.220
zk1.herpderp.example.com  IN TXT   "id: i-11f5d5fe"
zk1.herpderp.example.com  IN HINFO "t2.micro"
```

### Why?

I wrote this a long time ago and I don't really remember why.  I guess
it seemed like a good idea at the time?  Maybe someone will find it to
be interesting or useful.
