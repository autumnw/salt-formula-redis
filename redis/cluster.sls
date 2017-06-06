{%- from "redis/map.jinja" import server with context %}
{%- from "redis/map.jinja" import cluster with context %}

redis_sentinel:
  service.running:
  - enable: true
  - name: {{ cluster.service }}
  - watch:
    - file: {{ server.conf_dir }}/{{ cluster.service }}.conf
  - require:
    - pkg: redis_packages

{{ server.conf_dir }}/{{ cluster.service }}.conf:
  file.managed:
  - source: salt://redis/files/{{ server.version }}/sentinel.conf
  - template: jinja
  - user: redis
  - group: redis
  - mode: 640
  - require:
    - pkg: redis_packages
