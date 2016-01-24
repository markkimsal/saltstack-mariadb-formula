{% from "mariadb/map.jinja" import mariadb with context %}
{% set settings = salt['pillar.get']('mariadb', {}) %}

include:
  - mariadb.install

{% if mariadb.service_provider == 'runit' %}
runit_service_file:
  file.managed:
    - name: /etc/service/mariadb/run
    - source: salt://mariadb/files/mariadb_runit.sh
    - user: mysql
    - group: mysql
    - makedirs: True
    - mode: 744
    - require:
      - pkg: install-mariadb

mariadb_service_running:
  service:
    - running
    - provider: runit
    - name: {{ mariadb.service }}
    - require:
      - pkg: install-mariadb

{% else %}

mariadb_service_running:
  service.running:
    - name: {{ mariadb.service }}
    - enable: True
    - reload: True
    - require:
      - pkg: install-mariadb
{% endif %}
