FROM alpine:3.14

RUN apk update && apt upgrade 

RUN apk add nginx openssl

RUN mkdir -p /etc/ssl/private && mkdir -p /etc/ssl/certs

RUN openssl req -x509 \ 
				-nodes \
				-sha256 \
				-days 3650 \
				-newkey rsa:2048 \
				-subj "/CN=mmondell.42.fr/C=CA/ST=Quebec/L=Quebec City/O=42Network/OU=42Quebec" \
				-keyout /etc/ssl/private/nginx_ssl.key \
				-out /etc/ssl/certs/nginx_ssl.crt

RUN mkdir /var/www/html

COPY ./tools/site/* /var/www/html/

COPY ./tools/default.conf /etc/nginx/http.d/default.conf

CMD [ "nginx", "-g", "deamon off;"]

EXPOSE 443 9000
