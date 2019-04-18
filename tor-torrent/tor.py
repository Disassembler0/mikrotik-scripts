#!/usr/bin/python3
# -*- coding: utf-8 -*-

import csv
import re
import requests

src_auth_dirs = 'https://gitweb.torproject.org/tor.git/plain/src/app/config/auth_dirs.inc'
src_fallback_dirs = 'https://gitweb.torproject.org/tor.git/plain/src/app/config/fallback_dirs.inc'
src_blutmagie = 'https://torstatus.blutmagie.de/query_export.php'

destination = '/var/www/html/tor.rsc'

ips_dir = []
ips_guard = []
ips_exit = []

ip_re = re.compile(r'(?<![0-9])(?:(?:[0-1]?[0-9]{1,2}|2[0-4][0-9]|25[0-5])[.](?:[0-1]?[0-9]{1,2}|2[0-4][0-9]|25[0-5])[.](?:[0-1]?[0-9]{1,2}|2[0-4][0-9]|25[0-5])[.](?:[0-1]?[0-9]{1,2}|2[0-4][0-9]|25[0-5]))(?![0-9])')

try:
    # Get directory nodes
    for src in (src_auth_dirs, src_fallback_dirs):
        r = requests.get(src)
        for line in r.text.splitlines():
            m = ip_re.search(line)
            if m:
                ips_dir.append(m.group(0))

    # Get guard and exit nodes
    r = requests.get(src_blutmagie)
    reader = csv.DictReader(r.text.splitlines())
    for row in reader:
        if row['Flag - Guard'] == '1':
            ips_guard.append(row['IP Address'])
        if row['Flag - Exit'] == '1':
            ips_exit.append(row['IP Address'])

    # Create RouterOS lists
    with open(destination, 'w') as f:
        f.write('/ip firewall address-list\n')
        f.write('remove [find list=Tor-Dir]\n')
        f.write('remove [find list=Tor-Guard]\n')
        f.write('remove [find list=Tor-Exit]\n')
        for ip in sorted(set(ips_dir)):
            f.write('add list=Tor-Dir address={}\n'.format(ip))
        for ip in sorted(set(ips_guard)):
            f.write('add list=Tor-Guard address={}\n'.format(ip))
        for ip in sorted(set(ips_exit)):
            f.write('add list=Tor-Exit address={}\n'.format(ip))
except:
    pass
