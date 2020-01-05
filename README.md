# deribinvladimir_infra

### packer-base
###### How to create instance using our baked image reddit-full:
- `sudo gcloud compute instances create reddit-app --boot-disk-size=10GB --image-family reddit-full --machine-type=g1-small --tags puma-server --restart-on-failure`

### cloud-testapp - settings and notes
###### Settings for testapp:
testapp_IP = 34.89.145.106

testapp_port = 9292
###### How to create instance using startup.sh:
- `gcloud compute instances create reddit-app --boot-disk-size=10GB --image-family ubuntu-1604-lts --image-project=ubuntu-os-cloud --machine-type=g1-small --tags puma-server --restart-on-failure --metadata startup-script=startup.sh`
- `gcloud compute instances create reddit-app --boot-disk-size=10GB --image-family ubuntu-1604-lts --image-project=ubuntu-os-cloud --machine-type=g1-small --tags puma-server --restart-on-failure --metadata startup-script-url=https://storage.googleapis.com/otus-devops-2019-11-vd/startup.sh`
###### How to create firewall rule using gcloud:
- `gcloud compute firewall-rules create default-puma-server --allow tcp:9292 --target-tags=puma-server`

*Note: I didn't set all other parameters because in our case their default values are match with desired ones*

### cloud-bastion - settings and notes
###### How to connect to second machine using one string:
- `ssh -A -t <user>@<bastion-ext-ip> ssh <user>@<someinternalhost-ip>`
###### How to connect to second machine using something like "ssh someinternalhost":
- add to local host to end of file /etc/ssh/ssh_config next strings:
```
        Host someinternalhost
            HostName someinternalhost
            ForwardAgent Yes
            ProxyJump <user>@<bastion-ext-ip>
            User <user>
            IdentifyFile ~/.ssh/<privatekeyfilename>
```
- run `ssh someinternalhost`

*Note: it also should works with ~/.ssh/config, but in my case it don't work, and I don't have any ideas why*

###### How to add let's encrypt certificate to our vpn-server:
- just go to "settings" in our pritunl web interface and add `<bastion-ext-ip>.sslip.io` to "let's encrypt domain" field, then reopen your pritunl web interface in browser using `<bastion-ext-ip>.sslip.io` instead of `<bastion-ext-ip>`

###### Settings for VPN-connection:
bastion_IP = 35.240.97.78

someinternalhost_IP = 10.132.0.4
