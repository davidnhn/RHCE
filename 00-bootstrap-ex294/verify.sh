#!/bin/bash
set -euo pipefail

ansible-inventory -i inventory.yml --list -y >/dev/null
ansible bootstrap -i inventory.yml -m ansible.builtin.ping
ansible-navigator run playbooks/smoke.yml -i inventory.yml --mode stdout

echo "Scenario 00 verification OK"
