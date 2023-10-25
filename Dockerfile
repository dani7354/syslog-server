FROM ubuntu:23.10
RUN apt update && apt install rsyslog -y

COPY rsyslog.conf /etc/rsyslog.conf

EXPOSE 514
ENTRYPOINT ["rsyslogd", "-n"]