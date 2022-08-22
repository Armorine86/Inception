FROM alpine:3.15

EXPOSE 443

RUN apk update && apk upgrade

RUN apk add nginx openssl

RUN mkdir -p /var/www/html
COPY conf/index.html /var/www/html/index.html

COPY ./conf/default.conf /etc/nginx/http.d/default.conf

RUN mkdir -p /etc/ssl/private
RUN mkdir -p /etc/ssl/certs

RUN openssl req -x509 \ 
				-nodes \
				-sha256 \
				-days 3650 \
				-newkey rsa:2048 \
				-subj "/CN=mmondell.42.fr/C=CA/ST=Quebec/L=Quebec City/O=42 Network/OU=42 Quebec" \
				-keyout /etc/ssl/private/nginx_ssl.key \
				-out /etc/ssl/certs/nginx_cert.crt

CMD ["nginx", "-g", "daemon off;"]
