MAKEFLAGS += --silent

.PHONY: setup

setup: setup-ansible setup-roles

# this is not needed here as we do this via playbook
setup-ansible:
	rm -rf ./openshift-ansible && \
	git clone https://github.com/openshift/openshift-ansible.git -b release-3.9

setup-roles:
	ansible-galaxy install -r roles/requirements.yml -c 

ocp-prepare:
	ansible-playbook -i inventories/dev/ plays/ocp-prepare.yml

ocp-intall-logging:
	ansible-playbook -i inventories/dev/ plays/ocp-install-logging.yml