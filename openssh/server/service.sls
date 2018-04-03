{%- from "openssh/map.jinja" import server with context %}
{%- if server.enabled %}

openssh_server_packages:
  pkg.latest:
  - names: {{ server.pkgs }}

{%- if server.banner is defined %}

{# CIS 5.2.15 requires Banner option configured. It also proposes
   file name '/etc/issue.net' as a solution, if Banner is not configured.
   WARNING: Some security scanners accepts only '/etc/issue.net'
   as a valid banner file name, so please do not change it.
#}

/etc/issue.net:
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
