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
#.  Import music.
#.  Adjust upload limits.

.. _funkwhale architecture: https://docs.funkwhale.audio/developers/architecture.html
.. _funkwhale compose file: https://dev.funkwhale.audio/funkwhale/funkwhale/-/blob/develop/deploy/docker-compose.yml
.. _funkwhale multi-container installation: https://docs.funkwhale.audio/installation/docker.html#docker-multi-container
