=======
OpenSSH
=======

OpenSSH is a FREE version of the SSH connectivity tools that technical users of the Internet rely on. Users of telnet, rlogin, and ftp may not realize that their password is transmitted across the Internet unencrypted, but it is. OpenSSH encrypts all traffic (including passwords) to effectively eliminate eavesdropping, connection hijacking, and other attacks. Additionally, OpenSSH provides secure tunneling capabilities and several authentication methods, and supports all SSH protocol versions. 

Sample pillar
=============

OpenSSH client
--------------

OpenSSH client with shared private key

.. code-block:: yaml

    openssh:
      client:
        enabled: true
        user:
          root:
            enabled: true
            private_key:
              type: rsa
              key: ${_param:root_private_key}
            user: ${linux:system:user:root}

OpenSSH client with individual private key and known host

.. code-block:: yaml

    openssh:
      client:
        enabled: true
        user:
          root:
            enabled: true
            user: ${linux:system:user:root}
            known_hosts:
            - name: repo.domain.com
              type: rsa
              fingerprint: dd:fa:e8:68:b1:ea:ea:a0:63:f1:5a:55:48:e1:7e:37

Configure keep alive settings:

.. code-block:: yaml

    openssh:
      client:
        alive:
          interval: 600
          count: 3

OpenSSH server
--------------

OpenSSH server with configuration parameters

.. code-block:: yaml

    openssh:
      server:
        enabled: true
        permit_root_login: true
        public_key_auth: true
        password_auth: true
        host_auth: true
        banner: Welcome to server!
        bind:
          address: 0.0.0.0
          port: 22

OpenSSH server with auth keys for users.
Parameter ``purge`` will ensure exact authorized_keys contents co undefined
keys will be removed.

.. code-block:: yaml

    openssh:
      server:
        enabled: true
        bind:
          address: 0.0.0.0
          port: 22
        ...
        user:
          newt:
            enabled: true
            user: ${linux:system:user:newt}
            public_keys:
            - ${public_keys:newt}
          root:
            enabled: true
            purge: true
            user: ${linux:system:user:root}
            public_keys:
            - ${public_keys:newt}

You can also bind openssh on multiple addresses and ports:

.. code-block:: yaml

    openssh:
      server:
        enabled: true
        binds:
          - address: 127.0.0.1
            port: 22
          - address: 192.168.1.1
            port: 2222

OpenSSH server for use with FreeIPA

.. code-block:: yaml

    openssh:
      server:
        enabled: true
        bind:
          address: 0.0.0.0
          port: 22
        public_key_auth: true
        authorized_keys_command:
          command: /usr/bin/sss_ssh_authorizedkeys
          user: nobody

Configure keep alive settings:

.. code-block:: yaml

    openssh:
      server:
        alive:
          keep: yes
          interval: 600
          count: 3
    #
    # will give you an timeout of 30 minutes (600 sec x 3)

Read more
=========

* http://www.openssh.org/manual.html
* https://help.ubuntu.com/community/SSH/OpenSSH/Configuring
* http://www.cyberciti.biz/tips/linux-unix-bsd-openssh-server-best-practices.html
* http://www.zeitoun.net/articles/ssh-through-http-proxy/start

Documentation and Bugs
======================

To learn how to install and update salt-formulas, consult the documentation
available online at:

    http://salt-formulas.readthedocs.io/

In the unfortunate event that bugs are discovered, they should be reported to
the appropriate issue tracker. Use Github issue tracker for specific salt
formula:

    https://github.com/salt-formulas/salt-formula-openssh/issues

For feature requests, bug reports or blueprints affecting entire ecosystem,
use Launchpad salt-formulas project:

    https://launchpad.net/salt-formulas

You can also join salt-formulas-users team and subscribe to mailing list:

    https://launchpad.net/~salt-formulas-users

Developers wishing to work on the salt-formulas projects should always base
their work on master branch and submit pull request against specific formula.

    https://github.com/salt-formulas/salt-formula-openssh

Any questions or feedback is always welcome so feel free to join our IRC
channel:

    #salt-formulas @ irc.freenode.net
