#!/usr/bin/python3
# -*- coding: utf-8 -*-

import requests

country = 'cz'
source = 'http://www.ipdeny.com/ipblocks/data/aggregated/{}-aggregated.zone'.format(country)
destination = '/var/www/html/country-{}.rsc'.format(country)

ips = []
try:
    r = requests.get(source)
    for line in r.text.splitlines():
        ips.append(line)
    with open(destination, 'w') as f:
        f.write('/ip firewall address-list\n')
        f.write('remove [find list=country-{}]\n'.format(country))
        for ip in sorted(set(ips)):
            f.write('add list=country-{} address={}\n'.format(country, ip))
except:
    pass
