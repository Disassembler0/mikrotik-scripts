/ip firewall filter

# INPUT - General
add action=drop chain=input comment="Block Tor exit nodes" dst-address-list=Tor-Exit

# FORWARD - Output from LAN clients
add action=jump chain=forward comment="Jump to OUT-Tor rules" in-interface=bridge1-local jump-target=OUT-Tor out-interface=ether1-WAN
add action=drop chain=OUT-Tor comment="Block Tor directory nodes" dst-address-list=Tor-Dir
add action=drop chain=OUT-Tor comment="Block Tor guard nodes" dst-address-list=Tor-Guard
add action=return chain=OUT-Tor comment="Return from OUT-Tor rules"
