Java is a required.
https://jdk.java.net/

Extract the Java archive: tar xvf openjdk*_bin.tar.gz

Edit the crushftp_init,sh script to specify the Java you downloaded.
For example, change this: JAVA="java"
to this: JAVA=jdk-13.0.1/bin/java"

Run the init script:
chmod +x crushftp_init.sh
./crushftp_init.sh install

java -jar CrushFTP.jar -a crushadmin password

Now you can login at one of these URLs:

http://servername:8080/
http://servername:9090/
https://servername:443/
