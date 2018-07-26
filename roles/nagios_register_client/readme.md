# nagios_register_client

## Description:

This role registers or unregisters a Nagios client with the Nagios Server.

## Behaviour:

Registering the Nagios client with Nagios Server.

**Feature:** Register a Nagios Client with Nagios Server  
- **Given** a Nagios Server
- **Given** a new client to be registered
- **Given** a flag name task_type "Register"
- **When** deployment is executed
- **Then** Nagios client is register with Nagios Server  

Unregistering the Nagios client from Nagios Server.

**Feature:** Unregister a Nagios Client from Nagios Server  
- **Given** a Nagios Server
- **Given** an existing client to be unregistered
- **Given** a flag name task_type "Unregister"
- **When** deployment is executed
- **Then** Nagios client is unregistered from Nagios Server 

## Configuration:

Variable required upon execution of the role (not in the vars or defauls folders).
Needs to be provided to the role before execution.

| Variable  | Description  | Example  | 
|---|---|---|
| **nagios-clients** | Inventory group which contains the Nagios clients to be registered/unregistered |  |
| **nagios-server** | Inventory group which contains the Nagios server |  |
| **nagios_client_hostname** | The Nagios Client Hostname  | Taken from the inventory |
| **nagios_clientip_address** | The Nagios Client IP address  | Taken from Ansible facts |
| **task_type** | Selects whether to register or unregister a client. | `register` or `unregister` |

## Usage:

How to invoke the role from a playbook to register clients:


Example inventory;
```yaml
[nagios-server]
server001

[nagios-clients]
client001
client002
```

Example playbooks:
```yaml
- name: Register a client on Nagios server
  hosts: nagios-clients
  become: yes
  tasks:
    - name: Register/Unregister a Nagios Client              
      include_role:
        name: nagios_register_client
      vars:
        nagios_client_hostname: "{{ inventory_hostname }}"
        nagios_clientip_address: "{{ ansible_host }}"
        task_type: 'Register'
      delegate_to: "{{ hostvars[groups['nagios-server'][0]]['inventory_hostname'] }}"
```

How to invoke the role from a playbook to unregister clients:

```yaml
- name: Unregister a client on Nagios server
  hosts: nagios-clients
  become: yes
  tasks:
    - name: Register/Unregister a Nagios Client              
      include_role:
        name: nagios_register_client
      vars:
        nagios_client_hostname: "{{ inventory_hostname }}"
        task_type: 'Unregister'
      delegate_to: "{{ hostvars[groups['nagios-server'][0]]['inventory_hostname'] }}"
```
