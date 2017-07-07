:if ([:len [/file find name=vpn.pem]] > 0) do={ 
    /certificate remove [find name=vpn.pem_0]
    /certificate import file-name=vpn.pem passphrase=""
    /certificate import file-name=vpn.key passphrase=""
    /interface sstp-server server set certificate=vpn.pem_0
    /file remove vpn.pem
    /file remove vpn.key
}
