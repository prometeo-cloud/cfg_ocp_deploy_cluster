#!/usr/bin/env bash
# Installs an OCP instance - requires the location of the folder for the inventory to use to be passed in
# Example:
#   sh ./run.sh ./my_inventory_folder

# run OCP pre-install tasks
ansible-playbook -i $1 prepare.yml

# run OCP install tasks
ansible-playbook -i $1 /usr/share/ansible/openshift-ansible/playbooks/byo/config.yml | tee ~/ocp_deploy_cluster/byo-$(date +"%Y-%m-%d_%H-%M-%S").log

# run OCP post-install tasks
ansible-playbook -i $1 configure.yml