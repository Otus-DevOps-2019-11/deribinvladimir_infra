# deribinvladimir_infra
### deribinvladimir Infra repository
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
