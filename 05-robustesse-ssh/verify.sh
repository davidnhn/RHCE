#!/bin/bash
set -euo pipefail

test -f /etc/ssh/sshd_config.d/99-rhce-hardening.conf
/usr/sbin/sshd -t
systemctl is-active sshd

echo "Scenario 05 verification OK"
