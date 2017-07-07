/ip firewall filter

# FORWARD - General
add action=drop chain=forward comment="Drop blocked IPs" src-address-list=Blocked
add action=drop chain=forward comment="Log and drop malware traffic" dst-address-list=Malware log=yes log-prefix="OUT MALWARE:"
add action=accept chain=forward comment="Bypass firewall for allowed IPs" dst-address-list=Allowed

# FORWARD - Output from LAN clients
add action=jump chain=forward comment="Jump to \"OUT - Clients\" rules" in-interface=bridge1-local jump-target="OUT - Clients" out-interface=ether1-WAN
add action=accept chain="OUT - Clients" comment="Allow ICMP" protocol=icmp
add action=accept chain="OUT - Clients" comment="Allow FTP" dst-port=21 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow SSH" dst-port=22 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow SMTP" dst-port=25 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow DNS" dst-port=53 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow DNS" dst-port=53 protocol=udp
add action=accept chain="OUT - Clients" comment="Allow HTTP" dst-port=80 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow POP3" dst-port=110 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow NTP" dst-port=123 protocol=udp
add action=accept chain="OUT - Clients" comment="Allow IMAP" dst-port=143 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow SNMP" dst-port=161 protocol=udp
add action=accept chain="OUT - Clients" comment="Allow LDAP" dst-port=389 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow HTTPS" dst-port=443 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow QUIC" dst-port=443 protocol=udp
add action=accept chain="OUT - Clients" comment="Allow SMTPS" dst-port=465 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow Syslog" dst-port=514 protocol=udp
add action=accept chain="OUT - Clients" comment="Allow RTSP" dst-port=554 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow RTSP" dst-port=554 protocol=udp
add action=accept chain="OUT - Clients" comment="Allow Submission" dst-port=587 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow LDAPS" dst-port=636 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow Flash Socket Policy" dst-port=843 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow SFTP" dst-port=990 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow IMAPS" dst-port=993 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow POP3S" dst-port=995 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow SOCKS5" dst-port=1080 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow Blizzard games" dst-port=1119,3724,6012,6112-6119 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow Blizzard games" dst-port=1119,3724,6012,6112-6119 protocol=udp
add action=accept chain="OUT - Clients" comment="Allow OpenVPN" dst-port=1194 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow OpenVPN" dst-port=1194 protocol=udp
add action=accept chain="OUT - Clients" comment="Allow Xbox" dst-port=1836,3074 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow Xbox" dst-port=1836,3074,3544 protocol=udp
add action=accept chain="OUT - Clients" comment="Allow MQTT" dst-port=1883 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow RTMP" dst-port=1935 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow Squid" dst-port=3128 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow MySQL" dst-port=3306 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow RDP" dst-port=3389 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow STUN" dst-port=3478 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow STUN" dst-port=3478 protocol=udp
add action=accept chain="OUT - Clients" comment="Allow PlayStation" dst-port=3480,3658-3659 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow Teredo" dst-port=3544 protocol=udp
add action=accept chain="OUT - Clients" comment="Allow PlayStation" dst-port=3658-3659 protocol=udp
add action=accept chain="OUT - Clients" comment="Allow Viber" dst-port=4244,5242 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow Steam" dst-port=4379,4380,27000-27036 protocol=udp
add action=accept chain="OUT - Clients" comment="Allow Signal" dst-port=4433 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow SIP" dst-port=5060 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow SIP" dst-port=5060 protocol=udp
add action=accept chain="OUT - Clients" comment="Allow SIPS" dst-port=5061 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow OSCAR" dst-port=5190 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow XMPP" dst-port=5222 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow XMPPS, Apple Push" dst-port=5223 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow Google Play" dst-port=5228 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow Viber" dst-port=5243,9785 protocol=udp
add action=accept chain="OUT - Clients" comment="Allow XMPP Federation" dst-port=5269 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow PostgreSQL" dst-port=5432 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow VNC" dst-port=5900 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow TeamViewer" dst-port=5938 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow TeamViewer" dst-port=5938 protocol=udp
add action=accept chain="OUT - Clients" comment="Allow SUPL" dst-port=7275 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow Alternative HTTP" dst-port=8080 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow WinBox" dst-port=8291 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow Alternative HTTPS" dst-port=8443 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow MQTTS" dst-port=8883 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow TeamSpeak" dst-port=9987 protocol=udp
add action=accept chain="OUT - Clients" comment="Allow TeamSpeak" dst-port=10011,30033 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow Apple FaceTime" dst-port=16384-16387 protocol=udp
add action=accept chain="OUT - Clients" comment="Allow Apple FaceTime" dst-port=16393-16402 protocol=udp
add action=accept chain="OUT - Clients" comment="Allow Google Hangouts" dst-port=19302-19309 protocol=udp
add action=accept chain="OUT - Clients" comment="Allow Google Hangouts" dst-port=19305-19309 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow Steam" dst-port=27014-27050 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow Windows Update" dst-port=40001-40046 protocol=tcp
add action=accept chain="OUT - Clients" comment="Allow Windows Update" dst-port=40001-40046 protocol=udp
add action=accept chain="OUT - Clients" comment="Allow established and related connections" connection-state=established,related
add action=drop chain="OUT - Clients" comment="Drop invalid connections" connection-state=invalid
add action=drop chain="OUT - Clients" comment="Log and drop everything else" log=yes log-prefix="OUT FILTER:"
