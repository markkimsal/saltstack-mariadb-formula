{% from "mariadb/map.jinja" import mariadb with context %}
{% set settings = salt['pillar.get']('mariadb', {}) %}

include:
  - mariadb.install

install-mariadb-client:
  pkg.installed:
    - name: {{ mariadb.client }}
    - require: get-mariadb-repo
