{%- from "openssh/map.jinja" import client with context %}
{%- if client.enabled %}

include:
- openssh.client.service

{%- for xxx, user in client.get('user', {}).items() %}

{%- if user.private_key is defined %}

{{ user.user.home }}/.ssh/id_{{ user.private_key.type }}:
  file.managed:
  - user: {{ user.user.name }}
  - source: salt://openssh/files/private_key
  - mode: 400
  - template: jinja
  - defaults:
    user_name: {{ user.user.name }}
  - require: 
    - file: {{ user.user.home }}/.ssh

{%- if user.public_key is defined %}
{{ user.user.home }}/.ssh/id_{{ user.private_key.type }}.pub:
  file.managed:
  - user: {{ user.user.name }}
  - source: salt://openssh/files/public_key
  - mode: 400
  - template: jinja
  - defaults:
    user_name: {{ user.user.name }}
  - require: 
    - file: {{ user.user.home }}/.ssh
{%- endif %}

{%- endif %}

{%- endfor %}

{%- endif %}
