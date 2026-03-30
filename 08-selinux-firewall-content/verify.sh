#!/bin/bash
set -euo pipefail

systemctl is-active httpd
firewall-cmd --list-services | grep -qw http
getenforce
ls -Zd /srv/opsportal
getsebool httpd_can_network_connect
grep -E "^ServerTokens|^ServerSignature" /etc/httpd/conf/httpd.conf
curl -fsS http://localhost/ >/dev/null

echo "Scenario 08 verification OK"
