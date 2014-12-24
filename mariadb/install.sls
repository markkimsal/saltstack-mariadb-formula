{% set os = salt['grains.get']('os', None) %}
{% set os_family = salt['grains.get']('os_family', None) %}

install-mariadb:
  pkg.installed:
    - name: mariadb-server


{% if os == 'Ubuntu' %}

get-mariadb-repo:
  pkgrepo.managed:
    - humanname: MariaDB Repo
    - name: deb http://sfo1.mirrors.digitalocean.com/mariadb/repo/10.0/ubuntu {{ salt['grains.get']('oscodename', 'trusty') }} main
    - keyserver: keyserver.ubuntu.com
    - keyid: 1BB943DB
    - refresh_db: True
    - require_in:
      - pkg: install-mariadb

{% elif os_family == 'Debian' %}

  pkgrepo.managed:
    - humanname: MariaDB Repo
    - name: deb http://sfo1.mirrors.digitalocean.com/mariadb/repo/10.0/debian {{ salt['grains.get']('oscodename', 'wheezy') }} main
    - keyserver: keyserver.ubuntu.com
    - keyid: 1BB943DB
    - refresh_db: True
    - require_in:
      - pkg: install-mariadb

{% endif %}

