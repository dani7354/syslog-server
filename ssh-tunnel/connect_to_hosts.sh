#!/bin/bash
RSYSLOG_HOST="rsyslog"
REMOTE_PORT="5555"
SSH_DIR="/opt/ssh_tunnel/.ssh"
SSH_HOSTS_LIST_FILE="${SSH_DIR}/host_list"
SSH_KNOWN_HOSTS_PATH="${SSH_DIR}/known_hosts"
SSH_CONFIG_PATH="${SSH_DIR}/config"

[[ ! -x "$SSH_HOSTS_LIST_FILE" ]] || { echo "$SSH_HOSTS_LIST_FILE does not exist" >&2 ; exit 1; }
[[ ! -x "$SSH_KNOWN_HOSTS_PATH" ]] || { echo "${SSH_KNOWN_HOSTS_PATH} does not exist" >&2 ; exit 1; }
[[ ! -x "$SSH_PRIVATE_KEY_PATH" ]] || { echo "${SSH_PRIVATE_KEY_PATH} does not exist" >&2 ; exit 1; }

readarray -t hosts < "$SSH_HOSTS_LIST_FILE" 

for host in "${hosts[@]}"; do
    command="ssh -F ${SSH_CONFIG_PATH} -NfT -o UserKnownHostsFile=${SSH_KNOWN_HOSTS_PATH} -R ${REMOTE_PORT}:${RSYSLOG_HOST}:514 ${host}"
    pgrep -f -x "$command" > /dev/null 2>&1 || { echo "Connecting to ${host}..."; $command; }
done