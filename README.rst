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
            private_key: ${private_keys:vaio.newt.cz}
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

OpenSSH server with auth keys for users

.. code-block:: yaml

    openssh:
      server:
        enabled: true
        ...
        user:
          newt:
            enabled: true
            user: ${linux:system:user:newt}
            public_keys:
            - ${public_keys:newt}
          root:
            enabled: true
            user: ${linux:system:user:root}
            public_keys:
            - ${public_keys:newt}

Read more
=========

* http://www.openssh.org/manual.html
* https://help.ubuntu.com/community/SSH/OpenSSH/Configuring
* http://www.cyberciti.biz/tips/linux-unix-bsd-openssh-server-best-practices.html
* http://www.zeitoun.net/articles/ssh-through-http-proxy/start
