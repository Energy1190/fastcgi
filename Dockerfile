FROM debian

RUN apt-get update \
	&& apt-get install -y fcgiwrap perl \
	&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 9000
ENTRYPOINT /usr/bin/spawn-fcgi -a 0.0.0.0 -p 9000 -n -u www-data -g www-data /usr/sbin/fcgiwrap
