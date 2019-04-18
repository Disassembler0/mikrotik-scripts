/interface sstp-server server set enabled=yes port=8443
/ppp profile add dns-server=192.168.88.1 local-address=192.168.88.1 name=sstp remote-address=pool1
/ppp secret add name=client password=xxx profile=sstp service=sstp
