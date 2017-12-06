# cfg_ocp_deploy_cluster

## Description:

This playbook deploys a customer OCP cluster

## Behaviour:

**Feature:** Deploy OCP cluster

As a PaaS Operator I want to deploy a full OCP cluster for customer usage

- **Scenario:** OCP Cluster is fully deployed
- **Given:** at least one RHEL7 master node
- **Given:** at least one RHEL7 infra node
- **Given:** at least one RHEL7 compute node
- **Given:** a correctly configured inventory file
- **When:** the playbook is executed
- **Then:** nodes are checked to ensure pre-configuration is correct
- **Then:** the cluster is deployed

## Dependencies:

RPMS:
- ansible.x86_64.2.4.1.0-1.el7
- java-1.8.0-openjdk-headless.x86_64.1:1.8.0.151-1.b12.el7_4
- python-passlib.noarch.1.6.5-2.el7
- httpd-tools.x86_64 0:2.4.6-67.el7_4.6                                                                                                                                                               

Checkout the ansible installer into the same directory as the cfg_ocp_deploy_cluster checkout:
```
$ git clone https://github.com/openshift/openshift-ansible
$ pushd openshift-ansible ; git checkout -b release-3.6 origin/release-3.6 ; popd
```

The playbook uses the ocp_configure_node and rhel_register_node roles. These need to be loaded by running:

```
$ ansible-galaxy install -r requirements.yml --force
```
prior to running the playbook.

## Configuration:

A list of the external variables used by the playbook.

| Variable  | Description  | Example  | Where set |
|---|---|---|---|
| **redhat_username**  | A valid Red Hat portal usernam  |  myuser | vars/secrets.yml |
| **redhat_password**  | Red Hat portal password  |  myuserpassword | vars/secrets.yml |
| **redhat_subscription_poolid**  | Pool ID for an OCP subscription | 908adcef098098 | vars/secrets.yml |
| **min_cpu**  | List of minimum cpu requirements, by node_type | (defaults in  ocp_configure_node role)  | override in group_vars/all.yml if needed |
| **min_storage** | List of minimum storage requirements, by node_type | (defaults in ocp_configure_node role)  | override in group_vars/all.yml if needed |
| **min_memory** | List of minimum memory requirements, by node_type | (defaults in ocp_configure_node role)  | override in group_vars/all.yml if needed |
| **docker_device** | Device to use as docker storage | (defaults in ocp_configure_node role) | override in group_vars/all.yml if needed |

## Inventory:

The inventory file (inventory/inventory.yml) is broadly similar to a standard OCP inventory file. The only differences is that there is a new group called 'compute'.
The existing group 'nodes' is a superset of the 'masters' and 'compute' groups.

N.B For testing purposes, the installer resource checks are disabled (openshift_disable_check in the inventory).

## Authentication:

Basic authentication is configured at deployment. This requires an htpasswd file with a password for the admin user in the 'templates/' directory.

## Testing:

Testing is currently carried out on AWS servers. To test, do the following:

1. Create four t2.large VMs, each with an additional 10GB of EBS storage for use as docker storage.
2. Designate one node as master, one as infra, and the other two as compute.
3. Configure a security group so that all nodes can talk to each other, and are externally accessible via ssh.
4. Configure a security group for the master permitting external access on 8443.
5. Configure a security group for the infra node permitting external access on 80 and 443.
6. Update the inventory as required.
7. Edit inventory/group_vars/all.yml to override minimum cpu, storage etc limits, and set docker and gluster device names. An example is provided. 
8. Create an htpasswd file for the admin password and save it in templates (htpasswd -c templates/htpasswd admin)
9. Ensure that vars/secrets.yaml contains your Red Hat portal credentials and a poolid.

## Usage:

```
$ ansible-galaxy install -r requirements.yml --force
$ ansible-playbook playbook.yml --key-file <path_to_AWS_key>
```
