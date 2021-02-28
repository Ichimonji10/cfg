cfg
===

Configuration management code for my personal hosts.

Funkwhale
---------

To summarize the `Funkwhale multi-container installation`_ procedure:

.. code:: bash

    docker-compose up --detach funkwhale-pg
    docker-compose run --rm funkwhale-api python manage.py migrate
    docker-compose run --rm funkwhale-api python manage.py createsuperuser
    docker-compose up --detach

The Compose file in this repository gives services names that differ from are shown in the
`Funkwhale Compose file`_, so containers require some additional configuration.  To get a high-level
understanding of how the services fit together, see the `Funkwhale architecture`_ diagram.

After installation, make sure to do the following:

#.  Set a contact email.
#.  Import music. (This can be done in the web UI.)
#.  Adjust upload limits.

If files are moved or removed, consider running `management commands`_ and then re-importing the
relevant library. The most relevant management commands are as follows:

.. code:: bash

    # For each "track" object in the database, update or delete that object's reference to the
    # on-disk file.
    #
    # The track objects are retained, even if the corresponding file is absent. This will prevent
    # future imports of that file. The `prune_library` command can remove track objects.
    docker-compose run --rm funkwhale-api python manage.py check_inplace_files

    # For each track, album, or artist object in the database, if the corresponding file(s) is
    # absent, delete that database object.
    #
    # This command doesn't check to see if the corresponding file(s) are absent. The
    # `check_inplace_files` command does this.
    docker-compose run --rm funkwhale-api python manage.py prune_library --tracks --albums --artists

.. _funkwhale architecture: https://docs.funkwhale.audio/developers/architecture.html
.. _funkwhale compose file: https://dev.funkwhale.audio/funkwhale/funkwhale/-/blob/develop/deploy/docker-compose.yml
.. _funkwhale multi-container installation: https://docs.funkwhale.audio/installation/docker.html#docker-multi-container
.. _management commands: https://docs.funkwhale.audio/admin/commands.html
