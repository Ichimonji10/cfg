borg_backup_users
=================

Configure per-user backups with `Borg`_.

More specifically, do the following:

1.  Install `Borg`_.
2.  For each user for whom backups should be configured:

    1.  Install a script to perform a backup, at ``~/.local/bin/borg-backup.sh``.
    2.  Install ``borg-backup.{service,timer}``, and start and enable the timer unit. Lingering is
        not enabled, meaning that a user must be logged in for the timer unit to fire; but this role
        does correctly enable the timer unit even when the target user isn't currently logged in.

This role doesn't configure SSH in any way. The user is responsible for installing a private SSH key
and editing ``~/.ssh/config``.

The Borg repositories on the remote backup host are distinguished by user names.  As a result,
multiple users may back up to the same remote backup host.

Example playbook:

.. code-block:: yaml

    - hosts: all
      roles:
        - borg_backup_users
      vars:
        borg_backup_users_passphrases:
          alice: password
        borg_backup_users:
          - local_user: alice
            local_paths:
              - ~/Documents
              - ~/'my other stuff'
            remote_user: borg-user
            remote_host: borg-host.example.com

Variables:

``borg_backup_users``
    Optional, but most tasks are skipped if omitted. A list of users for whom backups will be
    configured. Each list entry is a dict with the following keys:

    ``local_user``
        Required. The name of the user for whom backups will be configured.

    ``local_paths``
        Optional, and defaults to ``["~/Documents", "~/Pictures"]``.  The paths to back up to the
        remote Borg repository. These paths are subject to Bash's expansion rules. If the paths
        contain whitespace or other interesting characters, consider using single quotes.

    ``remote_host``
        Optional, but some tasks are skipped if omitted. The hostname of the host which will host
        Borg backups.

    ``remote_user``
        Optional, but some tasks are skipped if omitted. The username on the remote host who will
        host borg backups.

``borg_backup_users_passphrases``
    Optional, but some tasks are skipped if omitted. Defaults to an empty dict. Maps local user
    names to the passphrases that those users will use when decrypting the remote Borg repository.

    A single local user could have multiple repositories on a single remote host, but I've opted to
    keep things simple and let each local user have one remote repository. Consequently,
    ``borg_backup_users[*]['local_user']`` is used to key ``borg_backup_users_passphrases``.

.. _Borg: https://borgbackup.readthedocs.io/en/stable/
