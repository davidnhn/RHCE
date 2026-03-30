#!/bin/bash
set -euo pipefail

test -x /usr/local/bin/archive-appdata.sh
test -d /srv/appdata
test -d /var/backups/appdata
test -f /etc/cron.d/rhce-appdata
grep -q "/usr/local/bin/archive-appdata.sh" /etc/cron.d/rhce-appdata

echo "Scenario 09 verification OK"
