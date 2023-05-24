# Only 3.15 includes python2
FROM alpine:3.15
RUN apk add --update --no-cache \
    sudo bash \
    git \
    python2 \
    gnuplot

RUN git config --global --add safe.directory '*'

COPY . /gitstats

RUN chmod +x /gitstats/docker/docker-entrypoint.sh \
    /gitstats/gitstats


WORKDIR /gitstats

USER root

ENTRYPOINT ["/gitstats/docker/docker-entrypoint.sh"]

CMD [""]

VOLUME /git-projects
VOLUME /output-reports