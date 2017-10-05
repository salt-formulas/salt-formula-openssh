openssh:
  client:
    enabled: true
    user:
      test:
        enabled: false
        name: test
        user: 
          enabled: true
          name: test
          sudo: true
          uid: 9999
          full_name: Test User
          home: /home/test
    known_hosts:
    - name: repo.domain.com
      type: rsa
      fingerprint: dd:fa:e8:68:b1:ea:ea:a0:63:f1:5a:55:48:e1:7e:37
    alive:
      interval: 600
      count: 3

