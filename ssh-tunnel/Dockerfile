FROM alpine:3.14

RUN apk add --no-cache openssh
RUN apk add --no-cache bash

WORKDIR /opt/ssh_tunnel

COPY ./ssh-tunnel/connect_to_hosts.sh .
RUN chmod +x connect_to_hosts.sh

RUN mkdir .ssh
RUN mkdir .secret

CMD ["./connect_to_hosts.sh"]
