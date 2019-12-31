#!/usr/bin/python3
# -*- coding: utf-8 -*-

import csv
import io
import ipaddress
import os
import requests
import zipfile

DST_DIR = '/var/www/html/ipblocks'
MAXMIND_LICENSE_KEY = 'YOUR_LICENSE_KEY'

# Dictionary of (name, ipv4, ipv6) tuples with geoname_id as key
countries = {'': ('unknown', [], [])}

with requests.Session() as session:
    # Download the zipped CSVs
    r = session.get('https://download.maxmind.com/app/geoip_download?edition_id=GeoLite2-Country-CSV&suffix=zip&license_key={}'.format(MAXMIND_LICENSE_KEY))

    # Unpack the zip in memory
    with zipfile.ZipFile(io.BytesIO(r.content)) as zip:
        date = zip.namelist()[0][21:29]

        # Parse countries CSV
        with io.BytesIO(zip.read('GeoLite2-Country-CSV_{}/GeoLite2-Country-Locations-en.csv'.format(date))) as f:
            reader = csv.reader(io.TextIOWrapper(f))
            next(reader, None) # Skip header
            for row in reader:
                country_code = row[4] if row[4] else row[2]
                countries[row[0]] = (country_code.lower(), [], [])

        # Parse IPv4 blocks CSV
        with io.BytesIO(zip.read('GeoLite2-Country-CSV_{}/GeoLite2-Country-Blocks-IPv4.csv'.format(date))) as f:
            reader = csv.reader(io.TextIOWrapper(f))
            next(reader, None)
            for row in reader:
                geoname_id = row[2] if row[2] else row[1]
                countries[geoname_id][1].append(row[0])

        # Parse IPv6 blocks CSV
        with io.BytesIO(zip.read('GeoLite2-Country-CSV_{}/GeoLite2-Country-Blocks-IPv6.csv'.format(date))) as f:
            reader = csv.reader(io.TextIOWrapper(f))
            next(reader, None)
            for row in reader:
                geoname_id = row[2] if row[2] else row[1]
                countries[geoname_id][2].append(row[0])

for country in countries.values():
    country_code = country[0]

    # Write IPv4 blocks file per country
    with open(os.path.join(DST_DIR, '{}.ipv4.blocks'.format(country_code)), 'w') as f:
        for block in country[1]:
            f.write(block)
            f.write('\n')

    # Write IPv6 blocks file per country
    with open(os.path.join(DST_DIR, '{}.ipv6.blocks'.format(country_code)), 'w') as f:
        for block in country[2]:
            f.write(block)
            f.write('\n')

    # Write collapsed IPv4 blocks file per country
    with open(os.path.join(DST_DIR, '{}.ipv4.collapsed'.format(country_code)), 'w') as f:
        for block in ipaddress.collapse_addresses([ipaddress.IPv4Network(b) for b in country[1]]):
            f.write(str(block))
            f.write('\n')

    # Write collapsed IPv6 blocks file per country
    with open(os.path.join(DST_DIR, '{}.ipv6.collapsed'.format(country_code)), 'w') as f:
        for block in ipaddress.collapse_addresses([ipaddress.IPv6Network(b) for b in country[2]]):
            f.write(str(block))
            f.write('\n')
