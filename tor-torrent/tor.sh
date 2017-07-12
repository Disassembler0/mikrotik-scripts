#!/bin/bash

RSCFILE=/var/www/html/tor.rsc
TMPDIR=$(mktemp -d)

echo -e "/ip firewall address-list\nremove [find list=Tor-Dir]\nremove [find list=Tor-Guard]\nremove [find list=Tor-Exit]" >${RSCFILE}

wget -q https://gitweb.torproject.org/tor.git/plain/src/or/fallback_dirs.inc -O ${TMPDIR}/tor.dir
wget -q https://gitweb.torproject.org/tor.git/plain/src/or/config.c -O - | sed '/^static const char \*default_authorities/,/^};$/!d;//d' >>${TMPDIR}/tor.dir
grep -Po '(\d+\.){3}\d+' ${TMPDIR}/tor.dir | sort -u | sed 's/^/add list=Tor-Dir address=/' >>${RSCFILE}

wget -q https://torstatus.blutmagie.de/query_export.php -O ${TMPDIR}/tor.csv
awk -F, '$12 == 1 {print "add list=Tor-Guard address="$5}' ${TMPDIR}/tor.csv | sort -u >>${RSCFILE}
awk -F, '$10 == 1 {print "add list=Tor-Exit address="$5}' ${TMPDIR}/tor.csv | sort -u >>${RSCFILE}

rm -rf ${TMPDIR}
