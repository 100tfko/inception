FROM debian:bullseye

#instlar dependencias
RUN apt-get update \
	&& apt-get install -y php-fpm php-mysql \
	&& rm -rf /var/lib/apt/lists/*



# Ensure the directory for the PID file exists
RUN mkdir -p /run/php
COPY ./www.conf /etc/php/7.4/fpm/pool.d/www.conf

EXPOSE 9000

CMD ["php-fpm7.4", "-F"]
