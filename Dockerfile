FROM anroots/sensu-client:example

RUN rm /etc/sensu/conf.d/default_checks.json

# Install .ee domain checker script
RUN cd /usr/local/bin && \
	git clone https://gist.github.com/636f71366a21fa62fa90.git && \
	mv 636f71366a21fa62fa90/check_ee_domain.py . && \
	rm -rf 636f71366a21fa62fa90 && \
	chmod +x check_ee_domain.py 

RUN gem install --verbose sensu-plugins-http && \
	pip install LinkChecker && \
	apt-get update && \
	apt-get install -y curl && \
	apt-get clean -y && \
	rm -rf /var/lib/apt/lists/*

COPY system-resources.json /etc/sensu/conf.d/


# TODO
#	RUN gem install --verbose sensu-plugins-aws	
#	RUN gem install --verbose sensu-plugins-consul
#	RUN gem install --verbose sensu-plugins-process-checks
#	RUN gem install --verbose sensu-plugins-dns
#	RUN gem install --verbose sensu-plugins-docker
#	RUN gem install --verbose sensu-plugins-network-checks
