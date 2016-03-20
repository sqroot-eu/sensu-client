FROM anroots/sensu-client:example

RUN rm /etc/sensu/conf.d/default_checks.json

# Install .ee domain checker script
RUN cd /usr/local/bin && \
	curl -O https://gist.githubusercontent.com/anroots/636f71366a21fa62fa90/raw/2361642931a68eb8c4b6042fee8e3f6986a6d27b/check_ee_domain.py && \
	chmod +x check_ee_domain.py 

RUN sensu-install -P http,docker

COPY system-resources.json /etc/sensu/conf.d/
