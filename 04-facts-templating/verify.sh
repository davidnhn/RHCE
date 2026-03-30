#!/bin/bash
set -euo pipefail

test -f /etc/rhce-lab/app-report.txt
grep -q "Managed by Ansible" /etc/rhce-lab/app-report.txt
cat /etc/rhce-lab/app-report.txt

echo "Scenario 04 verification OK"
