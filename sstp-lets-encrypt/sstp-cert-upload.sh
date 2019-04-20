#!/bin/sh

HOST=vpn.example.com
MTUSER=admin
MTADDR=192.168.88.1

scp /etc/acme-sh/${HOST}/fullchain.cer ${MTUSER}@${MTADDR}:/${HOST}.pem >/dev/null
scp /etc/acme-sh/${HOST}/${HOST}.key ${MTUSER}@${MTADDR}:/${HOST}.key >/dev/null

ssh -T ${MTUSER}@${MTADDR} <<EOF >/dev/null
:delay 3

/certificate remove [find common-name="${HOST}"]
/certificate import file-name="${HOST}.pem" passphrase=""
/certificate import file-name="${HOST}.key" passphrase=""

/file remove "${HOST}.pem"
/file remove "${HOST}.key"

# Reset SSTP certificate and prevent "cert hash not matching" errors
/interface sstp-server server set certificate=none
:delay 1
/interface sstp-server server set certificate="${HOST}.pem_0"
EOF
