{%- from "openssh/map.jinja" import server with context %}
{%- if server.enabled %}

{%- for user_name, user in server.user.items() %}

{%- if user.get('enabled', False) %}

{%- if user.public_keys is defined %}

{{ user.user.name }}_ssh_dir:
  file.directory:
  - name: {{ user.user.home }}/.ssh
  - user: {{ user.user.name }}
  - group: {{ user.user.name }}
  - mode: 700

{%- if user.get('purge', False) %}

{{ user.user.name }}_auth_keys:
  file.managed:
  - name: {{ user.user.home }}/.ssh/authorized_keys
  - user: {{ user.user.name }}
  - group: {{ user.user.name }}
  - mode: 644
  - template: jinja
  - source: salt://openssh/files/authorized_keys
  - require:
    - file: {{ user.user.name }}_ssh_dir
  - defaults:
      user_name: {{ user.user.name }}

{%- else %}

{{ user.user.name }}_auth_keys:
  ssh_auth.present:
  - user: {{ user.user.name }}
  - names:
    {%- for public_key in user.public_keys %}
    - {{ public_key.key }}
    {%- endfor %}
  - require:
    - file: {{ user.user.name }}_ssh_dir

{%- endif %}

{%- else %}

{%- if user.get('purge', False) %}
{{ user.user.name }}_auth_keys:
  file.absent:
  - name: {{ user.user.home }}/.ssh/authorized_keys
{%- endif %}

{%- endif %}

{%- endif %}

{%- endfor %}

{%- endif %}

