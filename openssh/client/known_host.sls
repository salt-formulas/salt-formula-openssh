{%- from "openssh/map.jinja" import client with context %}
{%- if client.enabled %}

include:
- openssh.client.service

{%- for xxx, user in client.get('user', {}).iteritems() %}

{%- for host in user.get('known_hosts', []) %}

{{ user.user.name }}_known_hosts_{{ host.name }}:
  ssh_known_hosts.present:
  - user: {{ user.user.name }}
  - name: {{ host.name }}
  - enc: {{ host.get('type', 'ecdsa') }}
  {%- if host.key is defined %}
  - key: {{ host.key }}
  {%- else %}
  - fingerprint: {{ host.fingerprint }}
  {%- if host.fingerprint_hash_type is defined %}
  - fingerprint_hash_type: {{ host.fingerprint_hash_type }}
  {%- endif %}
  {%- endif %}
  {%- if host.port is defined %}
  - port: {{ host.port }}
  {%- endif %}
  {%- if host.hash_known_hosts is defined %}
  - hash_known_hosts: {{ host.hash_known_hosts }}
  {%- endif %}
  - require:
    - pkg: openssh_client_packages
    - file: {{ user.user.home }}/.ssh

{%- endfor %}

{%- endfor %}

{%- endif %}
