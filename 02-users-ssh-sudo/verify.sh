#!/bin/bash
set -euo pipefail

for user in alice bob; do
  id "$user"
  getent passwd "$user"
  test -f "/home/${user}/.ssh/authorized_keys"
done

test -f /etc/sudoers.d/99-ops
visudo -cf /etc/sudoers.d/99-ops >/dev/null

echo "Scenario 02 verification OK"
