#!/bin/bash
set -euo pipefail

host="${1:-localhost}"

systemctl is-enabled httpd
systemctl is-active httpd
firewall-cmd --list-services | grep -qw http
curl -fsS "http://${host}/" >/dev/null

echo "Scenario 01 verification OK"
