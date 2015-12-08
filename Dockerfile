FROM skorochkin/java-gradle:latest

ENV NODE_VERSION=0.12 \
    # hotfix for ultra slow npm install on Ubuntu
    NPM_CONFIG_REGISTRY=http://registry.npmjs.org/ \
    PHANTOMJS_VERSION=2.0.0-20150528 \
    PHANTOMJS_BIN=/usr/local/bin/phantomjs2

# install required packages
RUN apt-get update -qq && apt-get -y -qq --no-install-recommends install build-essential python python-dev libwebp5 libfontconfig1 libjpeg8 libicu52

RUN curl --silent --location https://deb.nodesource.com/setup_${NODE_VERSION} | bash - && \
    apt-get -y install nodejs
    # && \
RUN npm cache clean && \
    npm install -g --no-optional npm bower && \
    npm install -g --no-optional --verbose build npm-cache gulp

RUN mkdir -p /tmp/phantomjs2 && cd /tmp/phantomjs2 && \
    wget -qO- -O phantomjs2.zip https://github.com/bprodoehl/phantomjs/releases/download/v${PHANTOMJS_VERSION}/phantomjs-${PHANTOMJS_VERSION}-u1404-x86_64.zip && \
    unzip -qq phantomjs2.zip && \
    mv ./phantomjs-${PHANTOMJS_VERSION}/bin/phantomjs ${PHANTOMJS_BIN}

# cleanup
RUN rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/* && apt-get clean

CMD []
