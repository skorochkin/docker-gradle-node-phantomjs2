FROM skorochkin/java-gradle:latest

ENV NODE_VERSION=0.12 \
    PHANTOMJS_VERSION=2.0.0-20150528 \
    PHANTOMJS_BIN=/usr/local/bin/phantomjs2

# install required packages
RUN apt-get update -qq && apt-get -y -qq --no-install-recommends install build-essential python python-dev libwebp5 libfontconfig1

RUN mkdir -p /tmp/libjpeg8 && cd /tmp/libjpeg8 && \
    wget -qO- -O libjpeg8.deb http://http.us.debian.org/debian/pool/main/libj/libjpeg8/libjpeg8_8d1-2_amd64.deb && \
    dpkg --install libjpeg8.deb

RUN curl --silent --location https://deb.nodesource.com/setup_${NODE_VERSION} | bash - && \
    apt-get -y install nodejs && \
    npm cache clean && \
    npm install npm bower -g && \
    npm install build npm-cache gulp -g

RUN mkdir -p /tmp/phantomjs2 && cd /tmp/phantomjs2 && \
    wget -qO- -O phantomjs2.zip https://github.com/bprodoehl/phantomjs/releases/download/v${PHANTOMJS_VERSION}/phantomjs-${PHANTOMJS_VERSION}-u1404-x86_64.zip && \
    unzip -qq phantomjs2.zip && \
    mv ./phantomjs-${PHANTOMJS_VERSION}/bin/phantomjs ${PHANTOMJS_BIN}

# cleanup
RUN rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/* && apt-get clean

CMD []
