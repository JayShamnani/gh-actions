#!/bin/bash

apt update

apt-get install -y rsync

apt-get install -y ssh

cd $GITHUB_WORKSPACE

ls -al
hostname=139.59.11.116
mkdir $HOME/.ssh

SSH_DIR="$HOME/.ssh"

ssh-keygen -t rsa -b 4096 -C "GH-actions-ssh-dep    loy-key" -f "$HOME/.ssh/id_rsa" -N ""

	cat > /etc/ssh/ssh_config <<EOL

Host $hostname
	HostName $hostname
	ProxyJump jumphost
	UserKnownHostsFile /etc/ssh/known_hosts
	User $ssh_user
EOL
# echo "$PRIVATE_KEY" | tr -d '\r' > "$SSH_DIR/id_ed25519"
# chmod 600 "$SSH_DIR/id_ed25519"
# eval "$(ssh-agent -s)"
# ssh-add "$SSH_DIR/id_ed25519"

rsync -avzhp $GITHUB_WORKSPACE/example.txt root@139.59.11.116:/home/jayshamnani