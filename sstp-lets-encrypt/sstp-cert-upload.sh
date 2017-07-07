#!/bin/sh

scp -i /opt/vpn/vpn-ssh-key /opt/vpn/vpn.example.com/fullchain.cer admin@192.168.88.1:/vpn.pem
scp -i /opt/vpn/vpn-ssh-key /opt/vpn/vpn.example.com/vpn.example.com.key admin@192.168.88.1:/vpn.key
