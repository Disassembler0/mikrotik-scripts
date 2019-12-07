#!/usr/bin/python3
# -*- coding: utf-8 -*-

country = 'cz'
source = '/var/www/html/ipblocks/{}.ipv4.collapsed'.format(country)
destination = '/var/www/html/country-{}.rsc'.format(country)

with open(source) as src, open(destination, 'w') as dst:
    dst.write('/ip firewall address-list\n')
    dst.write('remove [find list=CZ.zone]\n')
    for block in src.readlines():
        dst.write('add list=CZ.zone address={}'.format(block))
