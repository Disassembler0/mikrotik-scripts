/ip firewall layer7-protocol
add name=torrent-tcp regexp="^(\\x13BitTorrent protocol|GET /announce\\\?info_hash=)"
add name=torrent-udp regexp="^(\\x04\\x17\\x27\\x10\\x19\\x80|d1:ad2:id20:)"

/ip firewall address-list
add address=dht.vuze.com list=Torrent
add address=inside.bitcomet.com list=Torrent
add address=dispersy1.tribler.org list=Torrent
add address=dispersy2.tribler.org list=Torrent
add address=dispersy3.tribler.org list=Torrent
add address=dispersy4.tribler.org list=Torrent
add address=dispersy5.tribler.org list=Torrent
add address=dispersy6.tribler.org list=Torrent
add address=dispersy7.tribler.org list=Torrent
add address=dispersy8.tribler.org list=Torrent

/ip firewall filter
add action=jump chain=forward comment="Jump to OUT-Torrent" jump-target=OUT-Torrent out-interface=ether1-WAN
add action=drop chain=OUT-Torrent comment="Bootstrap hosts" dst-address-list=Torrent
add action=drop chain=OUT-Torrent comment="Teredo" dst-port=3544 protocol=udp
add action=drop chain=OUT-Torrent comment="DHT Routers" dst-port=6881 protocol=udp
add action=drop chain=OUT-Torrent comment="L7 UDP" layer7-protocol=torrent-udp protocol=udp
add action=drop chain=OUT-Torrent comment="L7 TCP" layer7-protocol=torrent-tcp protocol=tcp
add action=return chain=OUT-Torrent comment="Return from OUT-Torrent rules"
