FROM anapsix/alpine-java:8_jdk_unlimited

LABEL maintainer "Alessandro Servino, alessandro.servino@ti8m.ch"

ADD ./CrushFTP9 /var/opt/CrushFTP9
ADD ./setup.sh /var/opt/setup.sh
ADD ./crushftp_init.sh /var/opt/crushftp_init.sh
ADD ./mysql-connector-java-5.1.47-bin.jar /var/opt/CrushFTP9/mysql-connector-java-5.1.47-bin.jar


RUN	apk --no-cache add curl && \
	chmod +x /var/opt/crushftp_init.sh && \
	chmod +x /var/opt/setup.sh && \
    cd /var/opt/CrushFTP9 && java -jar /var/opt/CrushFTP9/CrushFTP.jar -a "fadmin" "admin"
    
ENTRYPOINT /var/opt/setup.sh

# FTP Server
EXPOSE 21
# HTTPS Server
EXPOSE 443
# FTP PASV transfers
EXPOSE 2000-2010
# SSH Server
EXPOSE 2222
# HTTP Servers
EXPOSE 8080 9090