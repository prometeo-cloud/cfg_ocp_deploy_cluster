#!/usr/bin/env bash
# restart the OCP master nodes
ansible masters -m service -a"name=atomic-openshift-master-api state=stopped"
ansible masters -m service -a"name=atomic-openshift-master-controllers state=stopped"
ansible nodes -m service -a"name=atomic-openshift-node state=stopped"
ansible nodes -m service -a"name=openvswitch state=restarted"
sleep 5
ansible masters -m service -a"name=atomic-openshift-master-api state=started"
ansible masters -m service -a"name=atomic-openshift-master-controllers state=started"
sleep 10
ansible masters -m service -a"name=atomic-openshift-node state=started" # (make sure masters are up before nodes)
sleep 15 # May need longer
ansible nodes -m service -a"name=atomic-openshift-node state=started"