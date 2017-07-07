:local recipient "mikrotik@example.com"
:local identity [/system identity get name]

/system backup save name=$identity
:delay 10
export file=$identity
:delay 10

:local mailbody ("Identity: " . $identity . "\r\nBoard name: " . [/system resource get board-name] . "\r\nSerial number: " . [/system routerboard get serial-number] . "\r\nRouterOS version: " . [/system resource get version] . "\r\nFirmware version: " . [/system routerboard get current-firmware])
/tool e-mail send to=$recipient subject=($identity . " - Backup") body=$mailbody file=($identity . ".backup")
/tool e-mail send to=$recipient subject=($identity . " - RSC") body=$mailbody file=($identity . ".rsc")
