# ocp_create_master_service_account

## Description:

This role creates a serviceaccount with a given cluster role.

## Behaviour:

**Feature:** Add service account to OpenShift

As a PaaS Operator
I want to postconfigure nodes
so that nodes are ready for automation of tenant administration and other tasks

- **Scenario:** OCP cluster is configured with a service account
- **Given:** a correctly deployed OCP cluster
- **When:** the cluster has been deployed
- **Then:** create the service account
- **Then:** apply the required policy to the service account
- **Then:** save the access token to a known file on the master for later retrieval

## Configuration:

A list of the external variables used by the role.

| Variable  | Description  | Example  | 
|---|---|---|
| **sa_name**  | The service account to configure  |  (defaults to 'automator') |
| **cluster_role**  | The cluster role to add to the SA  |  (defaults to 'cluster-admin') |
| **project** | The cluster in which to create the SA | (defaults to 'openshift-infra') |


## Usage:

How to invoke the role from a playbook:

```yaml
- name: Create SA
  include_role:
    name: ocp_create_master_service_account
  vars:
    sa_name: automator
    cluster_role: cluster-admin
    project: openshift-infra
```
The role will save the token to a file in root's home directory of the target host. The file is named: *&lt;project&gt;_&lt;sa&gt;_token*

Additionally, the role sets a fact, *automator_token*, with the contents of the token.