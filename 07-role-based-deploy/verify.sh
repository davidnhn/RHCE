#!/bin/bash
set -euo pipefail

systemctl is-active httpd
systemctl is-enabled httpd
firewall-cmd --list-services | grep -qw http
test -f /etc/httpd/conf.d/role-site.conf

echo "Scenario 07 verification OK"
