#!/bin/bash
set -euo pipefail

vgs vg_app
lvs /dev/vg_app/lv_data
lsblk
mountpoint /srv/appdata
findmnt /srv/appdata

echo "Scenario 03 verification OK"
