{% from "mariadb/map.jinja" import mariadb with context %}
{% set settings = salt['pillar.get']('mariadb', {}) %}

{% set os = salt['grains.get']('os', None) %}
{% set os_family = salt['grains.get']('os_family', None) %}

install-mariadb:
  pkg.installed:
    - name: {{ mariadb.server }}

{% if os == 'Ubuntu' %}
get-mariadb-repo:
  pkgrepo.managed:
    - humanname: MariaDB Repo
    - name: deb {{ mariadb.repo }}{{ mariadb.repo_version }}/ubuntu {{ salt['grains.get']('oscodename', 'trusty') }} main
    - keyserver: keyserver.ubuntu.com
    - keyid: 1BB943DB
    - refresh_db: True
    - require_in:
      - pkg: install-mariadb

{% elif os_family == 'Debian' %}
get-mariadb-repo:
  pkgrepo.managed:
    - humanname: MariaDB Repo
    - name: deb {{ mariadb.repo }}{{ mariadb.repo_version }}/debian {{ salt['grains.get']('oscodename', 'trusty') }} main
    - keyserver: keyserver.ubuntu.com
    - keyid: 1BB943DB
    - refresh_db: True
    - require_in:
      - pkg: install-mariadb

{% elif os_family == 'Redhat' %}
get-mariadb-repo:
  pkgrepo.managed:
    - humanname: MariaDB Repo
    - baseurl: {{ mariadb.repo }}{{ mariadb.repo_version }}/{{ mariadb.repo_dir }}
	- skip_if_unavailable: True
	- enabled: 1
{% endif %}
