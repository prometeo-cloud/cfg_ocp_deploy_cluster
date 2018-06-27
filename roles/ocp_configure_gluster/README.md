# ocp_configure_gluster

## Description:

This role sets a storageclass (by default glusterfs-storage) to be the default storageclass.

## Behaviour:

**Feature:** set a default storageclass

As a PaaS Operator
I want to set a default storageclass
so that deployment configurations will be able to allocate storage without modification.

- **Scenario:** OCP cluster is configured with a default storage class
- **Given:** a correctly deployed OCP cluster
- **Given:** the cluster has a storageclass defined
- **When:** the deployment is complete
- **Then:** assign default storage

## Configuration:

A list of the external variables used by the role.

| Variable  | Description  | Example  | 
|---|---|---|
| **storageclass**  | The storageclass to configure as default  |  (defaults to 'glusterfs-storage') |

## Usage:

How to invoke the role from a playbook:

```yaml
- name: Assign default storage
  include_role:
    name: ocp_configure_gluster
  vars:
    storageclass: glusterfs-storage
