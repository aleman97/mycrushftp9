#!/bin/bash
#!/bin/sh

function urldecode() { : "${*//+/ }"; echo -e "${_//%/\\x}"; }

if [ ! -d "/var/opt/CrushFTP9/users/MainUsers/fadmin" ]; then
	cd /var/opt/CrushFTP9 && java -jar /var/opt/CrushFTP9/CrushFTP.jar -a "fadmin" "admin"
fi

/var/opt/crushftp_init.sh start

if [ -z ${LCP_SECRET_DATABASE_USER+x} ];
then
        echo "LCP_SECRET_DATABASE_USER is unset";
else
        echo "LCP_SECRET_DATABASE_USER is set to '$LCP_SECRET_DATABASE_USER'"
		cat /var/opt/CrushFTP9/prefs.XML | grep "<db_user>"
		sed -i 's,<db_user>TOBESUBSTITUTED<\/db_user>,<db_user>'"$LCP_SECRET_DATABASE_USER"'<\/db_user>,1' /var/opt/CrushFTP9/prefs.XML
		cat /var/opt/CrushFTP9/prefs.XML | grep "<db_user>"
fi



if [ -z ${LCP_SECRET_DATABASE_PASSWORD+x} ];
then
        echo "LCP_SECRET_DATABASE_PASSWORD is unset";
else
        echo "LCP_SECRET_DATABASE_PASSWORD is set to '$LCP_SECRET_DATABASE_PASSWORD'";
		response="" 
		while [ -z "$response" ]; do
			sleep 20s;
			response=$(curl 'http://localhost:8080/WebInterface/function/' --data-raw 'command=encryptPassword&encrypt_type=DES&password='"$LCP_SECRET_DATABASE_PASSWORD"'');

			response=$(sed -E 's@.*\?>|<result><response>|<\/response><\/result>@@g' <<< $response)

			response=$(urldecode "$response")

			response=$(echo $response | xargs)
			echo $response

		done

		echo $response
		cat /var/opt/CrushFTP9/prefs.XML | grep "<db_pass>"
		sed -i 's,<db_pass>TOBESUBSTITUTED<\/db_pass>,<db_pass>'"$response"'<\/db_pass>,1' /var/opt/CrushFTP9/prefs.XML
		cat /var/opt/CrushFTP9/prefs.XML | grep "<db_pass>"

		pid_java=$(pidof java)
		echo $pid_java
		kill $pid_java
		sleep 10s

		pid_java=""
		while [ -z "$pid_java" ]; do
			/var/opt/crushftp_init.sh start
			pid_java=$(pidof java)
			echo "pid_java after restart "$pid_java
		done
fi




while true; do sleep 86400; done

#la stringa ottenuta è questa: <result><response>UFf407ISKDSxTEWuQQbA1Q3bD9XYAJqXR%2FilYfbMhHA%3D</response></result>
#devo estrapolare la solaparte centrale
#sed -E 's@<result><response>|<\/response><\/result>@@g'

#UFf407ISKDSxTEWuQQbA1Q3bD9XYAJqXR/ilYfbMhHA=
#UFf407ISKDSxTEWuQQbA1Q3bD9XYAJqXR%2FilYfbMhHA%3D

#need to url decode the string before copying it into the prefs.xml file



UFf407ISKDSxTEWuQQbA1Q3bD9XYAJqXR/ilYfbMhHA=
UFf407ISKDSxTEWuQQbA1Q3bD9XYAJqXR/ilYfbMhHA=