{%- from "openssh/map.jinja" import client with context %}
{%- from "linux/map.jinja" import network with context %}
{%- if client.enabled %}

openssh_client_packages:
  pkg.latest:
  - names: {{ client.pkgs }}

{%- if network.proxy.host != 'none' and not network.proxy.get("pkg_only", true) %}

openssh_client_proxy_packages:
  pkg.latest:
  - names: {{ client.proxy_pkgs }}

{%- endif %}

openssh_client_config:
  file.managed:
  - name: {{ client.config }}
  - user: root
  - group: root
  - source: salt://openssh/files/ssh_config
  - mode: 600
  - template: jinja
  - require:
    - pkg: openssh_client_packages

{%- for user_name, user in client.get('user', {}).items() %}

{%- if user.get('enabled', True) %}

{{ user.user.home }}/.ssh:
  file.directory:
  - user: {{ user.user.name }}
  - mode: 700
  - makedirs: true
  - require:
    - pkg: openssh_client_packages

openssh_client_{{ user_name }}_config:
  file.managed:
  - name: {{ user.user.home }}/.ssh/config
  - user: {{ user.user.name }}
  - source: salt://openssh/files/ssh_config
  - context:
      user_name: {{ user_name }}
  - mode: 600
  - template: jinja
  - require:
    - pkg: openssh_client_packages

{%- endif %}

{%- endfor %}

{%- endif %}
