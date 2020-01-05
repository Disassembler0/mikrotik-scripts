##Parametros globales
:global OutInterface "ether1"
##Bloqueo Redes Sociales
/ip firewall layer7-protocol
add name=Blocked regexp="^.*(facebook.com|twitter.com|instagram.com|hi5.com|t\
    agged.com|snapchat.com|match.com|pinterest.com|badoo.com|Instagram.com).*\
    \$"
##Bloqueo Youtube, youtube movil
add name=Youtube regexp="^.+(youtube.com|www.youtube.com|m.youtube.c\
    om|ytimg.com|s.ytimg.com|ytimg.l.google.com|googlevideo.com|youtu.be).*\$"

/ip firewall filter
add action=drop chain=forward comment="General Block" layer7-protocol=\
    Blocked out-interface=$OutInterface place-before=1
add action=drop chain=forward comment="Block Youtube" \
    layer7-protocol=Youtube out-interface=$OutInterface place-before=2