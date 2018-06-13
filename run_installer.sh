#!/usr/bin/env bash
# executes the ansible-openshift byo installer
# example of use:
#   $ sh ./run_installer.sh <<inventory_folder>>
ansible-playbook -i $1 /usr/share/ansible/openshift-ansible/playbooks/byo/config.yml | tee ~/ocp_deploy_cluster/byo-$(date +"%Y-%m-%d_%H-%M-%S").log