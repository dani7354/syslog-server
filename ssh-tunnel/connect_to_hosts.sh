#!/bin/bash
RSYSLOG_HOST="rsyslog"
REMOTE_PORT="5514"
SSH_DIR="/opt/ssh_tunnel/.ssh"
SSH_HOSTS_LIST_FILE="${SSH_DIR}/host_list"
SSH_KNOWN_HOSTS_PATH="${SSH_DIR}/known_hosts"
SSH_CONFIG_PATH="${SSH_DIR}/config"

[[ -r "$SSH_HOSTS_LIST_FILE"  ]] || { echo "SSH host list not found!" >&2; exit 1; }
[[ -r "$SSH_KNOWN_HOSTS_PATH"  ]] || { echo "SSH known hosts file not found!" >&2; exit 1; }
[[ -r "$SSH_CONFIG_PATH"  ]] || { echo "SSH config not found!" >&2; exit 1; }


connect() {
    command="ssh -F ${SSH_CONFIG_PATH} -NfT -o UserKnownHostsFile=${SSH_KNOWN_HOSTS_PATH} -R ${REMOTE_PORT}:${RSYSLOG_HOST}:514 ${1}"
    eval $command
    while true; do
        echo "Connection to ${1} active..."
        sleep 10
    done
}

readarray -t hosts < "$SSH_HOSTS_LIST_FILE"

for host in "${hosts[@]}"; do
    echo "Connecting to ${host}..."
    connect "$host" &
done

echo "Waiting for connections to exit"
wait
