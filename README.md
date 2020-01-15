# deribinvladimir_infra

### terraform-2
###### What's been done during this homework:
- firewall resource created and updated by inmport
- network_interface defined 
- base image separated and created by packer to two different images: one with Mongo DB and another one for Ruby
- terraform configuration also separated to app, db and vpc layers and checked to work
- terraform configurations converted to modules app, db and vpc, parametrized and checked to work
- updated and checked firewall rule to limit connections only from our provider's address
- created two environments, stage and prod, with the same modules usage
- added external storage-bucket module to create buckets
- bucket created to store terraform state and state moved on it
- provisioners added to deploy full workable environment
- provisioner for db instance modified to update mongo db config to allow connections from other instances
- setting added to update puma config with ip-address of instance with mongo db
- variable added and module updated to add possibility to make choice between full deploy with puma or only base deploy from packer images 
- after checking all results all resources deleted by "terraform destroy"
###### How works feature to choose between full deploy with provisioners and base deploy:
- added variable "provision_enabled" with boolean type to choice what we want
- added resource "null_resource" with logical "count" construction to make additional operations for "app" resource if value of "provision_enabled" is yes: "count = var.provision_enabled ? 1 : 0"
###### Additional resources used during this homework:
- https://losst.ru/komanda-sed-linux - to modify mongo db config (but other way is --bind_ip 0.0.0.0 + ss -nlp | grep port_number to check is mongo listening or not)
- https://www.terraform.io/docs/configuration/expressions.html, https://www.terraform.io/docs/modules/composition.html, 
https://www.terraform.io/docs/provisioners/remote-exec.html, https://www.terraform.io/docs/providers/null/resource.html - useful information about using different resources in our task
- https://registry.terraform.io/modules/SweetOps/storage-bucket/google/0.3.0 and https://github.com/SweetOps/terraform-google-storage-bucket - storage-bucket module
- https://medium.com/@gmusumeci/getting-started-with-terraform-and-google-cloud-platform-gcp-deploying-vms-in-a-private-only-f8b5ce7858d8 - some interesting examples how to make terraform config with instances, network, firewall rules, lb, autoscaling etc

### terraform-1
###### What's been done during this homework:
- terraform installed and initiated
- main.tf created with ssh-key, firewall rule and provisioners to deploy our reddit-base instance and install puma on it
- outputs.tf created to see ip-address of our instance
- variables.tf and terrafor.tfvars created and variables parametrized for our project
- few pub ssh keys for differents users added to check how it works
- added usage of private ssh key 
- checked behavior of terraform if metadata for ssh-key added through gui directly to project
- lb.tf added with instructions to create load balancer with our instance in it
- main.tf modified to create two reddit-base instances by copying section "google-compute-instance"
- main.tf modified to use count instead of copy-paste section "google-compute-instance" for each instance
- after checking all results all resources deleted by "terraform destroy"
###### What's going on when we add some resources directly to project through gui bypassing terraform configs update:
- if we add new ssh-key for new user to metadata of our gcp-project, nothing changes after "terraform apply" because this is global parameter and it's not defined in our terraform configs
- if we add new ssh-key for new user to metadata of our instance, "terraform apply" will delete it because it not match with our state from terraform configs
###### Additional resources used during this homework:
- https://cloud.google.com/load-balancing/docs/, and especially https://cloud.google.com/load-balancing/docs/https/ with scheme - **must read to understand how works load balancing in gcp**
- https://www.terraform.io/docs/providers/google/r/compute_forwarding_rule.html - **good doc** about resource "google_compute_forwarding_rule" **with good examples of full load balancing description** (I used it in my homework)
- https://www.terraform.io/docs/providers/google/r/compute_health_check.html - resource "google_compute_health_check" but it don't work in our case for unknown reason
- https://www.terraform.io/docs/providers/google/r/compute_instance.html - more parameters for resource "google_compute_instance"
- https://github.com/gruntwork-io/terraform-google-load-balancer - yet another **good description (see main.tf and other files) of load balancer resource** (I used it in my homework)
- https://coderoad.ru/38645002/%D0%9A%D0%B0%D0%BA-%D0%B4%D0%BE%D0%B1%D0%B0%D0%B2%D0%B8%D1%82%D1%8C-%D0%BA%D0%BB%D1%8E%D1%87-ssh-%D0%BA-%D1%8D%D0%BA%D0%B7%D0%B5%D0%BC%D0%BF%D0%BB%D1%8F%D1%80%D1%83-GCP-%D1%81-%D0%BF%D0%BE%D0%BC%D0%BE%D1%89%D1%8C%D1%8E-terraform - how to add a couple of pub ssh-keys to resource
- https://stackoverflow.com/questions/19622198/what-does-set-e-mean-in-a-bash-script, https://serverfault.com/questions/377092/bash-set-e-and-check-if-a-user-exists-make-script-exit, http://andrew.bogdanovs.com/post/bash_set_e_and_etc.html - some useful info about set parameter (it's for provisioner's scripts)
- https://github.com/terraform-google-modules, https://github.com/terraform-google-modules/terraform-google-lb-http - external module for terraform to create load balancers; unfortunately it was too hard for my brain and it not support google provider version 3+, only 2.15; https://cloud.google.com/community/tutorials/modular-load-balancing-with-terraform - description with schemes using this external module, can be useful

### packer-base
###### What's been done during this homework:
- ADC set up for GCP on local machine
- template and scripts created for pre-baked image 'reddit-base' creation with Ruby and Mongo DB installed
- template from previous step parametrized using more creation options
- template and scripts created for baked image 'reddit-full' creation with Puma, ready for work instantly after starting instance
###### How to create instance using our baked image reddit-full:
- `sudo gcloud compute instances create reddit-app --boot-disk-size=10GB --image-family reddit-full --machine-type=g1-small --tags puma-server --restart-on-failure`
###### Additional resources used during this homework:
- https://github.com/puma/puma/blob/master/docs/systemd.md
- https://www.shellhacks.com/ru/systemd-service-file-example/
- https://losst.ru/komanda-echo-v-linux, https://www.nixp.ru/recipes/21.html
- https://ixnfo.com/kak-ustanovit-midnight-commander-mc-v-ubuntu-18-04.html


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
