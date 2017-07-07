/ipv6 firewall filter

# INPUT
add chain=input in-interface=6to4-tunnel1 action=jump jump-target=wan-to-mkt comment="Jump to wan-to-mkt rules"
add chain=wan-to-mkt connection-state=established action=accept comment="Allow established connections"
add chain=wan-to-mkt connection-state=related action=accept comment="Allow related connections"
add chain=wan-to-mkt connection-state=invalid action=drop comment="Drop invalid connections"
add chain=wan-to-mkt protocol=icmpv6 action=accept comment="Accept ICMP"
add chain=wan-to-mkt action=drop log=yes log-prefix="6to4 INPUT:" comment="Log and drop everyting else"

# FORWARD
add chain=forward in-interface=6to4-tunnel1 action=jump jump-target=wan-to-lan comment="Jump to wan-to-lan rules"
add chain=wan-to-lan connection-state=established action=accept comment="Allow established connections"
add chain=wan-to-lan connection-state=related action=accept comment="Allow related connections"
add chain=wan-to-lan connection-state=invalid action=drop comment="Drop invalid connections"
add chain=wan-to-lan action=drop log=yes log-prefix="6to4 FORWARD:" comment="Log and drop everyting else"
