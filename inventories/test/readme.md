# Test Inventory

This is a test inventory intended to simplify the configuration of an inventory for deploying OCP.

There are currently two jinja2 files which required merging with variables as follows:

- [ansible_hosts.j2](ansible_hosts.j2)
- [osev3.yml.j2](./group_vars/osev3.yml.j2)

Merge variables are:

| Name | Description |
|---|---|
| instance | An identifier of the OCP cluster instance (e.g. 01, 02, etc) |
| domain | The domain name associated with the OCP instance (e.g. mydomain.com) |

The names of the merge files should be as they are but without the .j2 extension.