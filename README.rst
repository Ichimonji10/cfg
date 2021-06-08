cfg
===

Configuration management code for my personal hosts.

Sensitive data in the ``ansible`` and ``docker`` directories is encrypted with ansible-vault and
git-crypt, respectively. The latter confuses tools like shellcheck until ``git-crypt unlock ...`` is
executed.

Docker Layout
-------------

If a file is copied into a service while its backing image is being built, or if a file is mounted
into a service while it's running, then it should go into a subdirectory named after that service.
Recommended subdirectory names include:

*   copy
*   mount
*   compile

If a file isn't used by a service in this manner, it should go into the ``docker-compose``
directory.

This policy will prove problematic if a service named ``docker-compose`` is to be created, and no
solution for this possibility is provided at this time.

Deploy Funkwhale
----------------

To summarize the `Funkwhale multi-container installation`_ procedure:

.. code:: sh

    docker-compose up --detach funkwhale-pg
    docker-compose run --rm funkwhale-api python manage.py migrate
    docker-compose run --rm funkwhale-api python manage.py createsuperuser
    docker-compose up --detach

The Compose file in this repository gives services names that differ from are shown in the
`Funkwhale Compose file`_, so containers require some additional configuration.  To get a high-level
understanding of how the services fit together, see the `Funkwhale architecture`_ diagram.

If files are moved or removed, consider running `management commands`_ and then re-importing the
relevant library. The most relevant management commands are as follows:

.. code:: sh

    # For each "track" object in the database, update or delete that object's reference to the
    # on-disk file.
    #
    # The track objects are retained, even if the corresponding file is absent. This will prevent
    # future imports of that file. The `prune_library` command can remove track objects.
    docker-compose run --rm funkwhale-api python manage.py check_inplace_files

    # For each track, album, or artist object in the database, if the corresponding file(s) is
    # absent, delete that database object.
    #
    # This command doesn't check to see if the corresponding file(s) have moved. The
    # `check_inplace_files` command does this.
    docker-compose run --rm funkwhale-api python manage.py prune_library --tracks --albums --artists

Update Funkwhale
----------------

The update process is described in the `Funkwhale multi-container installation`_ documentation.
Typical steps are:

#.  Check for differences between the sample nginx configuration file and the one in this
    repository.
#.  Bump the version number in the Compose file.
#.  Pull and build new images.
#.  Migrate the database.
#.  Start the new images.

The following commands encapsulate the procedure:

.. code:: sh

    curl -O 'https://dev.funkwhale.audio/funkwhale/funkwhale/-/blob/1.1.2/deploy/docker.nginx.template'
    vimdiff docker.nginx.template docker/nginx/copy/etc-nginx-conf.d/funkwhale.jerebear.name.conf
    vim docker/docker-compose.yml
    docker-compose pull
    docker-compose build
    docker-compose run --rm funkwhale-api python manage.py migrate
    docker-compose up --detach

Transmission
------------

For some reason, Transmission doesn't write ``peer-port`` to ``settings.json`` upon shutdown. To set
this value:

.. code:: sh

    docker-compose stop transmission
    docker run -it --rm --mount source=docker_transmission-config,target=/mnt/config alpine /bin/sh
    docker-compose start transmission

And in the container:

.. code:: sh

    apk add jq
    echo "$(jq '."peer-port" = 58340' /mnt/config/settings.json)" > /mnt/config/settings.json
    jq '."peer-port"' < /mnt/config/settings.json

.. _funkwhale architecture: https://docs.funkwhale.audio/developers/architecture.html
.. _funkwhale compose file: https://dev.funkwhale.audio/funkwhale/funkwhale/-/blob/develop/deploy/docker-compose.yml
.. _funkwhale multi-container installation: https://docs.funkwhale.audio/installation/docker.html#docker-multi-container
.. _management commands: https://docs.funkwhale.audio/admin/commands.html
