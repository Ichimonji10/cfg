user_ichimonji10
================

Create and customize user ichimonji10.

This role accepts one variable: `user_ichimonji10_vimrc_color`. This variable
corresponds to the `color` attribute that may be set in a user's `~/.vimrc`.

On all hosts, do the following:

* Create a user that belongs to the appropriate groups, depending on the groups
  that the target host belongs to.
* Install several configuration files, plus the things (like directories) that
  they reference.

On VM hosts, also do the following:

* Install several custom executables for VM management.
* Create a user-specific libvirt configuration file.

On workstations, also do the following:

* Install several additional applications and configuration files.
