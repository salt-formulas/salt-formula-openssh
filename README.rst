=====
Usage
=====

OpenSSH is a free version of the SSH connectivity tools that technical users
of the Internet rely on. The passwords of Telnet, remote login (rlogin), and
File Transfer Protocol (FTP) users are transmitted across the Internet
unencrypted. OpenSSH encrypts all traffic, including passwords, to effectively
eliminate eavesdropping, connection hijacking, and other attacks. Additionally,
OpenSSH provides secure tunneling capabilities and several authentication
methods, and supports all SSH protocol versions.

This file provides the sample pillars configurations for different use cases.

**OpenSSH client**

* The OpenSSH client configuration with a shared private key:

  .. code-block:: yaml

      openssh:
        client:
          enabled: true
          use_dns: False
          user:
            root:
              enabled: true
              private_key:
                type: rsa
                key: ${_param:root_private_key}
              user: ${linux:system:user:root}

* The OpenSSH client configuration with an individual private key and known
  host:

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
                fingerprint_hash_type: sha256|md5

* The OpenSSH client configuration with keep alive settings:

  .. code-block:: yaml

     openssh:
       client:
         alive:
           interval: 600
           count: 3

**OpenSSH server**

* The OpenSSH server simple configuration:

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

* The OpenSSH server configuration with auth keys for users:

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

  .. note:: Setting the ``purge`` parameter to ``true`` ensures that the exact
     ``authorized_keys`` contents will be filled explicitly from the model and
     undefined keys will be removed.

* The OpenSSH server configuration that binds OpenSSH on multiple addresses
  and ports:

  .. code-block:: yaml

    openssh:
      server:
        enabled: true
        binds:
          - address: 127.0.0.1
            port: 22
          - address: 192.168.1.1
            port: 2222

* The OpenSSH server with FreeIPA configuration:

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

* The OpenSSH server configuration with keep alive settings:

  .. code-block:: yaml

    openssh:
      server:
        alive:
          keep: yes
          interval: 600
          count: 3
    #
    # will give you an timeout of 30 minutes (600 sec x 3)

* The OpenSSH server configuration with the DSA legacy keys enabled:

  .. code-block:: yaml

    openssh:
      server:
        dss_enabled: true

* The OpenSSH server configuration with the duo 2FA
https://duo.com/docs/duounix
with Match User 2FA can be bypassed for some accounts

  .. code-block:: yaml

    openssh:
      server:
        use_dns: false
        password_auth: false
        challenge_response_auth: true
        ciphers:
          aes256-ctr:
            enabled: true
          aes192-ctr:
            enabled: true
          aes128-ctr:
            enabled: true
        authentication_methods:
          publickey:
            enabled: true
          keyboard-interactive:
            enabled: true
        match_user:
          jenkins:
            authentication_methods:
              publickey:
                enabled: true



* OpenSSH server configuration supports AllowUsers, DenyUsers, AllowGroup,
DenyGroups via allow_users, deny_users, allow_groups, deny_groups keys respectively.

For example, here is how to manage AllowUsers configuration item:

  .. code-block:: yaml

    openssh:
      server:
        allow_users:
          <user_name>:
            enabled: true
          <pattern_list_name>:
            enabled: true
            pattern: <pattern>

Elements of allow_users are either user names or pattern list names:
* <user name> goes to configurational file as is.
* <pattern list name> is not used directly - its main purpose is to provide a
  meaningfull name for a pattern specified in 'pattern' key. Another advantage
  is that pattern can be overriden.

<enabled> by default is 'true'.

See PATTERNS in ssh_config(5) for more information on what <pattern> is.

**CIS Compliance**

There is a number of configuration options that make the OpenSSH service
compliant with CIS Benchmark. These options can be found under
``metadata/service/server/cis``, and are not enabled by default. For each CIS
item a comprehensive description is provided with the pillar data.

See also https://www.cisecurity.org/cis-benchmarks/ for the details abouth
CIS Benchmark.

**Read more**

* http://www.openssh.org/manual.html
* https://help.ubuntu.com/community/SSH/OpenSSH/Configuring
* http://www.cyberciti.biz/tips/linux-unix-bsd-openssh-server-best-practices.html
* http://www.zeitoun.net/articles/ssh-through-http-proxy/start

**Documentation and bugs**

* http://salt-formulas.readthedocs.io/
   Learn how to install and update salt-formulas

* https://github.com/salt-formulas/salt-formula-openssh/issues
   In the unfortunate event that bugs are discovered, report the issue to the
   appropriate issue tracker. Use the Github issue tracker for a specific salt
   formula

* https://launchpad.net/salt-formulas
   For feature requests, bug reports, or blueprints affecting the entire
   ecosystem, use the Launchpad salt-formulas project

* https://launchpad.net/~salt-formulas-users
   Join the salt-formulas-users team and subscribe to mailing list if required

* https://github.com/salt-formulas/salt-formula-openssh
   Develop the salt-formulas projects in the master branch and then submit pull
   requests against a specific formula

* #salt-formulas @ irc.freenode.net
   Use this IRC channel in case of any questions or feedback which is always
   welcome
