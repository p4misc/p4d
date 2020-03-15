FROM ubuntu:bionic as ubuntu18
LABEL maintainer "p4misc <p4miscjp@gmail.com>"

ARG TCP_PORT
ARG P4PORT
ARG P4_SUPER_USER
ARG P4_SUPER_PASSWD
ARG P4_SERVER_ID
ARG P4_UNICODE
ARG P4_CASE
ARG P4_SAMPLE_DEPOT

ENV TCP_PORT=${TCP_PORT}
ENV P4PORT=${P4PORT}
ENV P4_SUPER_USER=${P4_SUPER_USER}
ENV P4_SUPER_PASSWD=${P4_SUPER_PASSWD}
ENV P4_SERVER_ID=${P4_SERVER_ID}
ENV P4_UNICODE=${P4_UNICODE}
ENV P4_CASE=${P4_CASE}
ENV P4_SAMPLE_DEPOT=${P4_SAMPLE_DEPOT}

RUN apt-get update -y \
    && apt-get install -y wget unzip gnupg2 vim \
    && wget -qO - https://package.perforce.com/perforce.pubkey | apt-key add - \
    && echo "deb http://package.perforce.com/apt/ubuntu bionic release" > /etc/apt/sources.list.d/perforce.list \
    && apt-get update -y \
    && apt-get install helix-p4d -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN /opt/perforce/sbin/configure-helix-p4d.sh ${P4_SERVER_ID} -n -p ${P4PORT} -r /opt/perforce/servers/${P4_SERVER_ID} -u ${P4_SUPER_USER} -P ${P4_SUPER_PASSWD} ${P4_UNICODE} --case ${P4_CASE} \
    && sed -i "/P4ROOT/a\P4PORT = ${P4PORT}" /etc/perforce/p4dctl.conf.d/${P4_SERVER_ID}.conf

USER perforce

COPY --chown=perforce:perforce run.sh sampledepot.sh /opt/perforce/
RUN cd /opt/perforce \
    && chmod u+x sampledepot.sh \
    && /opt/perforce/sampledepot.sh \
    && chmod u+x run.sh

EXPOSE 1666

HEALTHCHECK \
    --interval=2m \
    --timeout=30s \
    CMD p4 -p ${P4PORT} info -s > /dev/null || exit 1

CMD ["/opt/perforce/run.sh"]
