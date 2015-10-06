{%- from "openssh/map.jinja" import server with context %}
{%- if server.enabled %}

{%- for user_name, user in server.user.iteritems() %}

{%- if user.public_keys is defined %}

{{ user.user.name }}_auth_keys:
  ssh_auth.present:
  - user: {{ user.user.name }}
  - names:
    {%- for public_key in user.public_keys %}
    - {{ public_key.key }}
    {%- endfor %}

{%- endif %}

{%- endfor %}

{%- endif %}