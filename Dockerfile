FROM alpine

ADD . /gitflow
RUN mkdir /src
RUN apk add -U --virtual .deps git \
    && rm -rf /var/cache/apk/*
RUN apk add -U --virtual .build-deps make \
    && cd /gitflow \
    && make install \
    && apk del .build-deps \
    && rm -rf /var/cache/apk/*

WORKDIR /src
ENTRYPOINT ["git", "flow"]
