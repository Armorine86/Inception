# Parent image layer
FROM alpine:3.14

# Opens ports
EXPOSE 443 9000

# Update and upgrade apt-get
RUN apk update
RUN apk upgrade

# Install dependencies
RUN apk add nginx openssl

# Create root folder for the webpage and Copy the index.html inside
RUN mkdir -p /var/www/html
COPY tools/index.html /var/www/html/index.html

# Copy custom config file to nginx default config folder
COPY ./tools/default.conf /etc/nginx/http.d/default.conf

# Create folders for private keys and certificate
RUN mkdir -p /etc/ssl/private
RUN mkdir -p /etc/ssl/certs

RUN openssl req -x509 \ 
				-nodes \
				-sha256 \
				-days 3650 \
				-newkey rsa:2048 \
				-subj "/CN=mmondell.42.fr/C=CA/ST=Quebec/L=Quebec City/O=42Network/OU=42Quebec" \
				-keyout /etc/ssl/private/nginx_ssl.key \
				-out /etc/ssl/certs/nginx_cert.crt

# Specify commands to run at Runtime when the container is set
CMD ["nginx", "-g", "daemon off;"]
