# Install new cluster


## prepare nodes

to install cluster we need to prepare it first

ansible-playbook -i inventories/dev/ plays/prepare.yml

check docker:
ansible all -i  inventories/dev/ -m shell -a "systemctl status docker"

## install bastions

ansible-playbook -i inventories/dev/ plays/install-ansible-controller.yml 

https://github.com/mjudeikis/
## kick of new install


On controller:
git clone https://github.com/mjudeikis/cfg_ocp_deploy_cluster.git -b refactor

make setup-ansible

# get inventory:
git clone https://github.com/mjudeikis/prometeo-cloud-private.git

ansible-playbook -i inventories/dev/ plays/ocp-install.yml