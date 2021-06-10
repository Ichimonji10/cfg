docker
======

Install, configure, and start docker, and add users to the ``docker`` group.

Docker isn't available in the default Fedora repos, so a Docker repository is enabled. For more
information on installation, see:

*   https://docs.docker.com/engine/install/fedora/
*   https://developer.fedoraproject.org/tools/docker/docker-installation.html

Variables:

``docker_users``
    Users who shall be added to the ``docker`` group, so that they may interact with the docker
    daemon without using sudo. Beware that belonging to the ``docker`` group is sudo-equivalent.
