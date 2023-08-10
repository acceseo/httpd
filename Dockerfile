FROM httpd:2.4

ENV HTTPD_SERVERNAME localhost
ENV HTTPD_APP_DIRECTORY /app
ENV HTTPD_FPM_HANDLER php.local:9000
ENV TZ=Europe/Madrid

RUN mkdir -p ${HTTPD_APP_DIRECTORY}

RUN apt-get update && apt-get install -y ssl-cert

RUN sed -i \
    # Load httpd-default.conf
    -e 's/^#\(Include .*httpd-default.conf\)/\1/' \
    # Load httpd-mpm.conf
    -e 's/^#\(Include .*httpd-mpm.conf\)/\1/' \
    # Enable SSL
    -e 's/^#\(Include .*httpd-ssl.conf\)/\1/' \
    -e 's/^#\(LoadModule .*mod_ssl.so\)/\1/' \
    -e 's/^#\(LoadModule .*mod_socache_shmcb.so\)/\1/' \
    # Enable rewrite
    -e 's/^#\(LoadModule .*mod_rewrite.so\)/\1/' \
    # Enable FCGI
    -e 's/^#\(LoadModule .*mod_proxy.so\)/\1/' \
    -e 's/^#\(LoadModule .*mod_proxy_fcgi.so\)/\1/' \
    # Disable autoindex
    -e 's/^\(LoadModule .*mod_autoindex.so\)/#&/' \
    -e 's/DirectoryIndex index.html/DirectoryIndex index.php/' \
    # Set ServerName
    -e 's/^#ServerName www.example.com:80/ServerName \${HTTPD_SERVERNAME}:80/' \
    # Set app directory
    -e 's/\/usr\/local\/apache2\/htdocs/\${HTTPD_APP_DIRECTORY}/' \
    conf/httpd.conf

RUN sed -i \
    # Set ServerName
    -e 's/^ServerName www.example.com:443/ServerName \${HTTPD_SERVERNAME}:443/' \
    # Set app directory
    -e 's/\/usr\/local\/apache2\/htdocs/\${HTTPD_APP_DIRECTORY}/' \
    # Set certificate path
    -e 's/\/usr\/local\/apache2\/conf\/server.key/\/etc\/ssl\/private\/ssl-cert-snakeoil.key/' \
    -e 's/\/usr\/local\/apache2\/conf\/server.crt/\/etc\/ssl\/certs\/ssl-cert-snakeoil.pem/' \
    conf/extra/httpd-ssl.conf

COPY httpd-fpm.conf /usr/local/apache2/conf/extra/httpd-fpm.conf
RUN echo "Include conf/extra/httpd-fpm.conf" >> /usr/local/apache2/conf/httpd.conf

COPY httpd-directory.conf /usr/local/apache2/conf/extra/httpd-directory.conf
RUN echo "Include conf/extra/httpd-directory.conf" >> /usr/local/apache2/conf/httpd.conf
