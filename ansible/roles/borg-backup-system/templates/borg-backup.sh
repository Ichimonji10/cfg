#!/usr/bin/env bash
#
# Create and prune Borg backups. See: http://borgbackup.readthedocs.org. Ensure
# the SSH key is usable.
set -euo pipefail

export BORG_PASSPHRASE='{{ borg_backup_system_passphrase }}'
# As of this writing, `ssh hostname borg --version` returns 0.29.0.
export BORG_REMOTE_PATH=/usr/local/bin/borg1/borg1

repository="{{ borg_backup_system_remote_host }}:borg-backup-system-$(hostnamectl --static)"
archive="$(date --iso-8601=seconds)"

borg create --compression lzma "${repository}::${archive}" \
    {% for path in borg_backup_system_local_paths %} {{ path }} {% endfor %}

borg prune "${repository}" --keep-within 8d --keep-weekly 4 --keep-monthly 6
