#!/bin/bash
RSYSLOG_HOST="rsyslog"
REMOTE_PORT="5514"
SSH_USER="user"
SSH_DIR="/opt/ssh_tunnel/.ssh"
SSH_HOSTS_LIST_FILE="${SSH_DIR}/host_list"
SSH_KNOWN_HOSTS_PATH="${SSH_DIR}/known_hosts"
SSH_PRIVATE_KEY_PATH="${SSH_DIR}/id_ed25519"
readarray -t hosts < "$SSH_HOSTS_LIST_FILE" 

for host in "${hosts[@]}"; do
    command="ssh -i ${SSH_PRIVATE_KEY_PATH} -NfT -o UserKnownHostsFile=${SSH_KNOWN_HOSTS_PATH} -R ${REMOTE_PORT}:${RSYSLOG_HOST}:514 ${SSH_USER}@${host}"
    pgrep -f -x "$command" > /dev/null 2>&1 || { echo "Connecting to ${host}..."; $command; }
done