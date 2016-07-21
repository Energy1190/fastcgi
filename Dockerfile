FROM debian

RUN apt-get update \
	&& apt-get install -y --fix-missing fcgiwrap perl libfcgi-perl wget \
	&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget http://nginxlibrary.com/downloads/perl-fcgi/fastcgi-wrapper -O /usr/bin/fastcgi-wrapper.pl \
	&& wget http://nginxlibrary.com/downloads/perl-fcgi/perl-fcgi -O /etc/init.d/perl-fcgi \
	&& chmod +x /usr/bin/fastcgi-wrapper.pl \
	&& chmod +x /etc/init.d/perl-fcgi \
	&& /usr/bin/fastcgi-wrapper.pl
EXPOSE 9000 8999
ENTRYPOINT /usr/bin/spawn-fcgi -a 0.0.0.0 -p 9000 -n -u www-data -g www-data /usr/sbin/fcgiwrap
