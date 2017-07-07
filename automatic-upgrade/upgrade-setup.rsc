/tool e-mail
set address=10.0.0.1 from=mikrotik@example.com password=xxx port=587 start-tls=yes user=mikrotik@example.com

/system scheduler
add interval=1w name=backup on-event="/system script run upgrade" start-date=jan/01/2000 start-time=22:00:00
