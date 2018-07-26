# ocp_configure_node

## Description:

This role pre-configures a server for deployment of Openshift Container Platform.

## Behaviour:

**Feature:** Configure OCP Node

As a PaaS Operator
I want to preconfigure nodes
so that nodes are ready for OCP deployment

- **Scenario:** OCP node is successfully prepared for OCP deployment
- **Given:** there is enough storage
- **Given:** there is enough memory
- **Given:** there is enough CPU
- **When:** the deployment is executed
- **Then:** subscriptions are attached
- **Then:** repositories are enabled
- **Then:** prereqs are installed
- **Then:** docker storage is configured
- **Then:** ssh keys are deployed 

## Configuration:

A list of the external variables used by the role.

| Variable  | Description  | Example  | 
|---|---|---|
| **node_type**  | The type of node to preconfigure  |  One of master, infra, compute |
| **min_storage**  | List of minimum storage requirements, by node_type  |  (defaults in role) |
| **min_memory**  | List of minimum memory requirements, by node_type | (defaults in role)  |
| **min_cpu**  | List of minimum cpu requirements, by node_type | (defaults in role)  |
| **docker_device** | Device name for docker storage | (defaults to /dev/vdb) |
| **gluster_device** | Device name for gluster storage | (defaults to /dev/vdc) |
| **min_gluster_storage** | Minimum size for gluster storage, in GB |  (defaults to 50GB) |

## Testing:

The molecule test uses a vagrant box rather than a docker container, by default it will use a vagrant box called rhel74.
The role expects there to be a second drive ('vdb') and tests for this. You can add a second drive to your vagrant box by adding a line to your Vagrantfile 
found in ~/.vagrant.d/boxes/rhel74/0/libvirt/Vagrantfile like this:

```
 config.vm.provider :libvirt do |domain|
    domain.memory = 2048
    domain.cpus = 2
    domain.nested = true
    domain.volume_cache = 'none'
    domain.storage :file, :size => '10G'
  end
```

The vagrant box will need to be registered to RHN. Add a file secrets.yml to molecule/default/vars with the format:

```
redhat_username: <my RHN username>
redhat_password: <my RHN password>
redhat_subscription_poolid: <Pool ID to use>
```




## Usage:

How to invoke the role from a playbook:

```yaml
- name: Check OCP Node
  include_role:
    name: ocp_configure_node
  vars:
    node_type: 'master'
```
