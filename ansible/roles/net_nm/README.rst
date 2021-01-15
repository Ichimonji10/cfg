net_nm
======

Manage networking with NetworkManager and related tools.

Variables
---------

``net_nm_has_gui``
    Whether the target host has a GUI or not. If so, additional applications or services may be
    installed and configured.

``net_nm_install``
    Whether this role should install and configure applications and services, or uninstall and
    delete configuration files.

EXTRA SHIT
----------

This info should be moved to my personal notes.

----

``NetworkManager.conf`` is used to configure NetworkManager as a whole, including default options
for connection profiles (i.e. connections). When configuring NetworkManager, do not edit
``/etc/NetworkManager/NetworkManager.conf``:

    If a default NetworkManager.conf is provided by your distribution's packages, you should not
    modify it, since your changes may get overwritten by package updates. Instead, you can add
    additional .conf files to the /etc/NetworkManager/conf.d directory. These will be read in order,
    with later files overriding earlier ones.

After editing a NetworkManager configuration file, execute ``nmcli general reload``. For more
information on configuring NetworkManager, see NetworkManager.conf(5).

----

NetworkManager makes use of the concepts of connection profiles and settings. See nm-settings(5).
Connection profiles are saved in ``/etc/NetworkManager/system-connections`` as ``.nmconnection``
files. To edit a connection profile:

*   Edit a ``.nmconnection`` file and execute ``nmcli connection reload``.
*   Use ``nmcli connection modify`` for non-interactive modification.
*   Use ``nmcli connection edit`` for interactive modification.

----

To connect to a wireless network from the CLI, use a command like::

    nmcli device wifi connect Bolton_Wireless

To understand how NetworkManager handles DNS at a conceptual level, see `NetworkManager DNS
handling`_. And as an aside, it is probably redundant to set ``dns=systemd-resolved`` and
``systemd-resolved=true`` in ``NetworkManager.conf``.

----

Possible target hosts:

*   pine (no dnsmasq, no networkmanager-openvpn)
*   beech and tupelo (yes dnsmasq, yes networkmanager-openvpn)
*   amelanchier and aronia (separate role)

In separate role:

*   Accept bootps and domain TCP and UDP packets on shared interface(s).
*   Enable NAT.
*   Maybe statically install connection profile.

On pine:

*   Enable systemd-network. Disable dnsmasq.service, openvpn-client@ivpn.service, and
    transmission.service.
*   Create a symlink from /etc/resolv.conf to /run/systemd/resolve/resolv.conf.

.. _networkmanager dns handling: https://wiki.gnome.org/Projects/NetworkManager/DNS
