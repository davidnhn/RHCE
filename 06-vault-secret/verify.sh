#!/bin/bash
set -euo pipefail

test -d /etc/rhce-app
test -f /etc/rhce-app/app.env
stat -c "%a %U %G" /etc/rhce-app/app.env

echo "Scenario 06 verification OK"
