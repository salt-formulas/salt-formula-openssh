linux:
  system:
    enabled: true
    user:
      testusername: &_user
        enabled: true
        name: testusername
        sudo: true
        uid: 9999
        full_name: Test User
        home: /home/testusername
openssh:
  server:
    enabled: true
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
    syslog_facility: auth
    user:
      testusername:
        enabled: true
        public_keys:
          -
            key: "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCts9Ry......... user@example.com"
          -
            key: "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAB667779Ry......... user@example.com"
        # Include from linux.system.user structure
        user: *_user
    bind:
      address: 0.0.0.0
      port: 8000
    force_command: /usr/bin/toilet
    alive:
      keep: no
      interval: 600
      # count: 3
    allow_users:
      allowed_user:
        enabled: true
      test_pattern:
        pattern: "!*@*.dialup.example.com,*@*.example.com"
    deny_users:
      denied_user:
        enabled: true
      test_pattern:
        pattern: "*@*.dialup.example.com"
    allow_groups:
      admin:
        enabled: true
      operator:
        enabled: true
    deny_groups:
      root:
        enabled: true
      wheel:
        enabled: true
