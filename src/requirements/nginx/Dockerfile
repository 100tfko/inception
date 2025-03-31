FROM debian:bullseye

#instalar dependencias
RUN apt-get update \
	&& apt-get install -y nginx openssl \
	&& rm -rf /var/lib/apt/lists/*
#esta ultima linea esta rara

RUN mkdir /certs
RUN openssl req -x509 -newkey rsa:2048 -days 365 -nodes -keyout /certs/lcuevas-.42.fr.key -out /certs/lcuevas-.42.fr.crt -subj "/C=SP/ST=Malaga/L=Malaga/O=42 Malaga/OU=erivero-/CN=lcuevas-"

# Create necessary directories
RUN mkdir -p /etc/nginx/conf.d /var/www/html
# copies config and init files givin them the necessary permissions
COPY ./nginx.conf /etc/nginx/nginx.conf
#COPY ./tools/nginx.sh /tmp/nginx.sh esta linea es de elisa
RUN chmod 644 /etc/nginx/nginx.conf 
#RUN chmod +x /tmp/nginx.sh
COPY ./nginx.conf /etc/nginx/sites-available/default

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]