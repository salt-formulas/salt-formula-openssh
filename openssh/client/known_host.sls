{%- from "openssh/map.jinja" import client with context %}
{%- if client.enabled %}

include:
- openssh.client.service

{%- for user_name, user in client.get('user', {}).iteritems() %}

{%- for host in user.get('known_hosts', []) %}

{{ user_name }}_known_hosts_{{ host.name }}:
  ssh_known_hosts.present:
  - user: {{ user_name }}
  - name: {{ host.name }}
  - enc: {{ host.get('type', 'ecdsa') }}
  - fingerprint_hash_type: {{ host.get('fingerprint_hash_type', 'md5') }}
  - fingerprint: {{ host.fingerprint }}
  - require:
    - pkg: openssh_client_packages
    - file: {{ user.user.home }}/.ssh

{%- endfor %}

{%- endfor %}

{%- endif %}
