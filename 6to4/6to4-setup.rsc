/interface 6to4
add name=6to4-tunnel1 local-address=123.45.67.89 remote-address=192.88.99.1 disabled=no
/ipv6 address
add address=2002:7b2d:4359::1/48 interface=6to4-tunnel1 advertise=no
add address=2002:7b2d:4359:1::1/64 interface=bridge1
/ipv6 route
add distance=1 dst-address=2000::/3 gateway=6to4-tunnel1
