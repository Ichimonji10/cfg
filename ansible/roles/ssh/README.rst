ssh
===

Create SSH client files.

This includes private keys and config files. A variable structure should be in
place for each host managed by this role:

.. code:: yaml

   ssh_users:
     alice:
       privkeys:
         host1.example.com: |
           host1.example.com private key
         host2.example.com: |
           host2.example.com private key
     bob:
       privkeys:
         host1.example.com: |
           host1.example.com private key
         host3.example.com: |
           host3.example.com private key
