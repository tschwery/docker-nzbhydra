FROM alpine
MAINTAINER Thomas Schwery <thomas@inf3.ch>

## Update base image and install prerequisites
RUN apk add --no-cache --virtual .fetch-deps \
        python2 py2-lxml tar curl

ENV HYDRAVERSION 0.2.218

ENV USERID 1000
ENV USERNAME nzbhydra

RUN addgroup -g ${USERID} -S ${USERNAME} \
    && adduser -S -G ${USERNAME} -u ${USERID} -s /bin/sh -h /home/${USERNAME} ${USERNAME}

RUN curl -SL https://github.com/theotherp/nzbhydra/archive/${HYDRAVERSION}.tar.gz \
    | tar zx \
    && mv /nzbhydra-${HYDRAVERSION} /nzbhydra \
    && chown ${USERID}:${USERID} /nzbhydra -R

USER nzbhydra

CMD ["/usr/bin/python2", "/nzbhydra/nzbhydra.py", "--nobrowser"]
