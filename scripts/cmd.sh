#!/usr/bin/env bash
# executes a shell command on all of the inventory hosts
# -b = become
# -m = module name
# -a = module args
ansible all -b -m shell -a "$1"