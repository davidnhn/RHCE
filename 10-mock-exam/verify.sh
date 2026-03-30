#!/bin/bash
set -euo pipefail

systemctl is-active httpd
firewall-cmd --list-services | grep -qw http
id alice
test -f /etc/sudoers.d/99-mock-ops
findmnt /srv/mockdata
test -f /etc/rhce-mock/report.txt
test -f /etc/cron.d/rhce-mock-backup
test -f /etc/rhce-mock/app.env
/usr/sbin/sshd -t

echo "Scenario 10 verification OK"
