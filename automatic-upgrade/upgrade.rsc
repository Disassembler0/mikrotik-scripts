:local recipient "mikrotik@example.com"
:local identity [/system identity get name]

/system package update check-for-update
:delay 5

:local current [/system package update get installed-version]
:local latest [/system package update get latest-version]

:if ([:tostr $latest] != "" && $current != $latest) do={
    :local mailbody ("Identity: " . $identity . "\r\nBoard name: " . [/system resource get board-name] . "\r\nSerial number: " . [/system routerboard get serial-number]  . "\r\nFrom version: " . $current . "\r\nTo version: " . $latest)
    /tool e-mail send to=$recipient subject=($identity . " - RouterOS has been upgraded") body=$mailbody
    /system package update install
}
