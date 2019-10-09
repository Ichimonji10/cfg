#!/usr/bin/env bash
#
# Create and prune Borg backups. See: https://borgbackup.readthedocs.org.
set -euo pipefail

export BORG_PASSPHRASE='{{ borg_backup_users_passphrases[borg_backup_user.local_user] }}'
# As of this writing, `ssh hostname borg --version` returns 0.29.0.
export BORG_REMOTE_PATH=/usr/local/bin/borg1/borg1

repository='{{ borg_backup_user.remote_host }}:borg-backup-user-{{ borg_backup_user.local_user }}'
archive="$(date --iso-8601=seconds)-$(hostname --short)"

borg create --compression lzma "${repository}::${archive}" \
    {% for path in borg_backup_user.local_paths | default(('~/Documents', '~/Pictures')) %} {{ path }} {% endfor %}

borg prune "${repository}" --keep-within 8d --keep-weekly 4 --keep-monthly 6
