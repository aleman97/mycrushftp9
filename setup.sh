#!/bin/bash
#!/bin/sh
if [ ! -d "/var/opt/CrushFTP9/users/MainUsers/fadmin"]; then
	cd /var/opt/CrushFTP9 && java -jar /var/opt/CrushFTP9/CrushFTP.jar -a "fadmin" "admin"
fi


/var/opt/crushftp_init.sh start

while true; do sleep 86400; done