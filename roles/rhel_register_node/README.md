# rhel_register_node

## Description:

Subscribe a system to Red Hat, either directly or via a Satellite
(See role **rhsatellite_configure_master** for additional configuration role)

_Note: Still work in progress_

## Behaviour:

**Feature:** Subscribe a system to Red Hat
- **Given** a VM of capable size and power is available
- **Given** the connection details to the VM are known
- **When** A new RHEL-system has been installed
- **Then** register it to Red Hat (or Satellite)
- **Then** attach subscriptions
- **Then** disable all other repositories
- **Then** enable base repository

## Configuration:

Common variables used by this role:

| Variable  | Description  | Example  | 
|---|---|---|
| **redhat_user** | Red Hat Username |  |
| **redhat_pass** | Red Hat Password | |
| **redhat_activationkey** | Red Hat Activation Key | |
| **redhat_organization_id** | Red Hat Organization ID |  |
| **redhat_pool_ids** | Red Hat Subscription Pool IDs |  |

## Usage:

How to invoke the role from a playbook:

```yaml
- name: Subscribe to Red Hat
  include_role:
    name: rhel_register_node
  vars:
    redhat_user: myuser
    redhat_password: myuser
```

Note: add common variables to the `vars` list as required.
