FROM ubuntu:23.10
RUN apt update && apt install rsyslog -y

RUN mkdir -p /var/log/remote
RUN chmod 775 /var/log/remote
RUN chown -R syslog:syslog /var/log/remote

COPY ./rsyslog.conf /etc/rsyslog.conf

EXPOSE 514
ENTRYPOINT ["rsyslogd", "-n"]