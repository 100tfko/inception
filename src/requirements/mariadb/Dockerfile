FROM debian:bullseye

RUN apt-get update && apt-get install -y \
	mariadb-server \
	&& rm -rf /var/lib/apt/lists/*

# Ensure MySQL directory exists
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

COPY ./my.cnf /etc/mysql/my.cnf

EXPOSE 3306

CMD ["mysqld"]