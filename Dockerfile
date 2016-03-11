FROM anroots/sensu-client:nagios

# Install .ee domain checker script
RUN cd /usr/local/bin && \
	git clone https://gist.github.com/636f71366a21fa62fa90.git && \
	mv 636f71366a21fa62fa90/check_ee_domain.py . && \
	rm -rf 636f71366a21fa62fa90 && \
	chmod +x check_ee_domain.py 

RUN gem install --verbose sensu-plugins-http
RUN pip install LinkChecker
RUN rm /etc/sensu/conf.d/default_checks.json

RUN apt-get update && \
	apt-get install -y curl && \
	rm -rf /var/lib/apt/lists/* /var/lib/cache/* /var/log/apt/* /tmp/* /var/tmp/*

COPY system-resources.json /etc/sensu/conf.d/

# ------------------------

	RUN gem install --verbose sensu-plugins-aws
	
#	RUN gem install --verbose sensu-plugins-consul
#	RUN gem install --verbose sensu-plugins-process-checks
#	RUN gem install --verbose sensu-plugins-dns
#	RUN gem install --verbose sensu-plugins-docker
#	RUN gem install --verbose sensu-plugins-network-checks


