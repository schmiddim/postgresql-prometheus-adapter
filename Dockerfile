FROM centos:7

LABEL org.opencontainers.image.authors="schmiddim@gmx.at"


COPY postgresql-prometheus-adapter start.sh /

ENTRYPOINT ["/start.sh"]

