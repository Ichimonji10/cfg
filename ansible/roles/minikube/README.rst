minikube
========

Install minikube and the libvirt backend.

After a user is added to the libvirt group, they must log in again in order for the group change to
take effect. Minikube can then be started with a command like:

.. code:: sh

    minikube start --driver=kvm2 --memory=8192MB
