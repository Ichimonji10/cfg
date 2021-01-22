btrfs_subvolume
===============

Periodically create and delete snapshots of btrfs subvolumes.

This role assumes that snapshots should be created within a ``snapshots`` directory alongside the
subvolume itself. This lends itself to a filesystem layout like so::

    home  # subvolume
    srv-airsonic
    snapshots  # directory
        home  # directory
            2019-01-01T13:00-04:00  # subvolume
            2019-01-02T13:00-04:00
            2019-01-03T13:00-04:00
        srv-airsonic
            2019-01-01T13:00-04:00
            2019-01-02T13:00-04:00
            2019-01-03T13:00-04:00

This role creates the ``snapshots/*`` directories, and units for creating and deleting btrfs
subvolumes in these directories. This role does not create the source subvolumes, like ``home`` in
the example above.

Example playbook:

.. code-block:: yaml

    - hosts: all
      roles:
        - name: btrfs_subvolume
          vars:
            btrfs_subvolumes:
              - path: /mnt/btrfs/home

Variables:

``btrfs_subvolumes``
    Optional, defaults to an empty list. A list of dicts, where each dict contains some information
    about a subvolume to manage. The following attributes may appear in each dict. If empty, only a
    few preliminary tasks are executed, such as installing btrfs-progs.

    ``path``
        Required. The path to a subvolume, relative to ``btrfs_path``.
