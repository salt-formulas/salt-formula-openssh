{%- from "openssh/map.jinja" import server with context %}
{%- if server.enabled %}

openssh_server_packages:
  pkg.latest:
  - names: {{ server.pkgs }}

{%- if server.banner is defined %}

/etc/banner:
  file.managed:
  - user: root
  - group: root
  - source: salt://openssh/files/banner
  - mode: 644
  - template: jinja
  - require:
    - pkg: openssh_server_packages
  - watch_in:
    - service: openssh_server_service

{%- endif %}

openssh_server_config:
  file.managed:
  - name: {{ server.config }}
  - user: root
  - group: root
  - source: salt://openssh/files/sshd_config
  - mode: 600
  - template: jinja
  - require:
    - pkg: openssh_server_packages

openssh_server_service:
  service.running:
  - name: {{ server.service }}
  - watch:
    - file: openssh_server_config

{%- endif %}
