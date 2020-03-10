FROM ubuntu:bionic as ubuntu18
LABEL maintainer "p4misc <p4miscjp@gmail.com>"

RUN apt-get update -y \
    && apt-get install -y vim wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV P4OSPASSWD He1ixAd@min

RUN useradd -U -m -d /opt/perforce perforce \
    && echo perforce:${P4OSPASSWD} | chpasswd \
    && install -m 770 -o perforce -g perforce -d \
          /opt/perforce \
          /opt/perforce/bin \
          /opt/perforce/sbin \
          /opt/perforce/p4root \
          /opt/perforce/p4root/ssl

USER perforce

RUN cd /opt/perforce/bin \
    && wget http://ftp.perforce.com/perforce/r19.2/bin.linux26x86_64/p4 \
    && chmod 770 p4
RUN cd /opt/perforce/sbin \
    && wget http://ftp.perforce.com/perforce/r19.2/bin.linux26x86_64/p4d \
    && chmod 770 p4d

COPY --chown=perforce:perforce setup.sh run.sh /opt/perforce/
RUN cd /opt/perforce \
    && chmod u+x *.sh \
    && ./setup.sh

EXPOSE 1666

CMD ["/opt/perforce/run.sh"]
