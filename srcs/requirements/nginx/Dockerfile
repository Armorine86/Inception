# Parent image layer
FROM debian:buster

# Opens ports
EXPOSE 443

RUN mkdir -p /var/www/html

COPY ./tools/site/* /var/www/html/

COPY ./tools/default.conf /etc/nginx/http.d/default.conf

# Update and upgrade apt-get
RUN apt update && apt upgrade -y
RUN apt-get update && apt-get upgrade -y

RUN apt install -y nginx \
				openssl

RUN mkdir -p /etc/ssl/private && mkdir -p /etc/ssl/certs

RUN openssl req -x509 \ 
				-nodes \
				-sha256 \
				-days 3650 \
				-newkey rsa:2048 \
				-subj "/CN=mmondell.42.fr/C=CA/ST=Quebec/L=Quebec City/O=42Network/OU=42Quebec" \
				-keyout /etc/ssl/private/nginx_ssl.key \
				-out /etc/ssl/certs/nginx_ssl.crt

# Specify commands to run at Runtime when the container is set
CMD ["nginx", "-g", "daemon off;"]
