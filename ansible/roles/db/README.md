###### Status of master branch builds: [![Build Status](https://travis-ci.com/deribinvladimir/otus201911-ansible4-db-role.svg?branch=master)](https://travis-ci.com/deribinvladimir/otus201911-ansible4-db-role)

# ansible4 db role

### ansible-3
###### What's been done during this homework:
- tasks for app and db were converted to roles using ansible-galaxy
- environments were created with group_vars for stage and prod
- playbooks were organized, ansible.cfg was updated, and deploy with new structure was checked
- community role jdauphant.nginx was added and checked to work with port 80
- ansible vault was added, credentials.yml and users.yml were created to create users and credentials.yml was encrypted by secret key
- travisci was configured to check master branch with terraform, tlint, ansible-lint and packer
###### Additional resources used during this homework:
- for travis setup: [status images](https://docs.travis-ci.com/user/status-images/), [customizing the builds](https://docs.travis-ci.com/user/customizing-the-build/), [few useful samples](https://rustycrate.ru/%D0%BE%D0%B1%D1%83%D1%87%D0%B5%D0%BD%D0%B8%D0%B5/2017/07/30/rust-travis.html), [how to test travis config changes locally](https://medium.com/@Nklya/%D0%BB%D0%BE%D0%BA%D0%B0%D0%BB%D1%8C%D0%BD%D0%BE%D0%B5-%D1%82%D0%B5%D1%81%D1%82%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5-%D0%B2-travisci-2b5ef9adb16e)
