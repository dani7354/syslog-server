FROM alpine:3.8

RUN apk add --no-cache openssh
RUN apk add --no-cache bash

WORKDIR /opt/ssh_tunnel

COPY connect_to_hosts.sh .
RUN chmod +x connect_to_hosts.sh

COPY ./crontab .
RUN crontab ./crontab

RUN mkdir .ssh

CMD ["crond", "-f"]
