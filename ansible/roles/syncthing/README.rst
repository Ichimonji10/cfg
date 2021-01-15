syncthing
=========

Install `Syncthing`_, and enable it for certain users.

Lingering is enabled if the target host is a server. Otherwise, it is left as-is.

Example playbook:

.. code:: yaml

    - hosts: all
      roles:
        - syncthing

Example variables file:

.. code:: yaml

    syncthing_usernames:
      - alice
      - bob

Variables:

``syncthing_usernames``
    Required. A list of user names for which syncthing is configured.

.. _syncthing: https://syncthing.net/
