FROM alpine
MAINTAINER Thomas Schwery <thomas@inf3.ch>

## Update base image and install prerequisites
RUN apk add --no-cache --virtual .fetch-deps \
        unzip curl openjdk8

ENV HYDRAVERSION 2.10.0

ENV USERID 1000
ENV USERNAME nzbhydra

RUN addgroup -g ${USERID} -S ${USERNAME} \
    && adduser -S -G ${USERNAME} -u ${USERID} -s /bin/sh -h /home/${USERNAME} ${USERNAME}

RUN curl -SOL https://github.com/theotherp/nzbhydra2/releases/download/v${HYDRAVERSION}/nzbhydra2-${HYDRAVERSION}-linux.zip \
    && unzip nzbhydra2-${HYDRAVERSION}-linux.zip -d /nzbhydra \
    && chown ${USERID}:${USERID} /nzbhydra -R \
    && chmod a+x /nzbhydra/nzbhydra2 \
    && rm nzbhydra2-${HYDRAVERSION}-linux.zip

RUN mkdir /data && chown ${USERID}:${USERID} /data -R
VOLUME /data

USER nzbhydra
ENTRYPOINT ["/usr/bin/java", "-jar", "/nzbhydra/lib/core-2.10.0-exec.jar", "directstart", "--nobrowser"]
