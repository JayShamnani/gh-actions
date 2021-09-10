#!/bin/bash

apt update

apt install -y rsync >/dev/null

apt install -y ssh >/dev/null

cd $GITHUB_WORKSPACE

ls -al
hostname=139.59.11.116
ssh_user=root
mkdir $HOME/.ssh

chmod 600 ~/.ssh

SSH_DIR="$HOME/.ssh"

echo "Jump Server ==============================================\n"


echo "$JUMPHOST_SERVER"

ssh-keygen -t rsa -b 4096 -C "GH-actions-ssh-dep    loy-key" -f "$HOME/.ssh/id_rsa" -N ""

function configure_ssh_config() {

if [[ -z "$JUMPHOST_SERVER" ]]; then

echo "Configuring KEYS ==============================================\n"
	# Create ssh config file. `~/.ssh/config` does not work.
	cat > /etc/ssh/ssh_config <<EOL
Host *
UserKnownHostsFile ${SSH_DIR}/known_hosts
IdentityFile ${SSH_DIR}/id_rsa
EOL
else
	# Create ssh config file. `~/.ssh/config` does not work.
	cat > /etc/ssh/ssh_config <<EOL
Host jumphost
	HostName $JUMPHOST_SERVER
	UserKnownHostsFile /etc/ssh/known_hosts
	User $ssh_user

Host $hostname
	HostName $hostname
	ProxyJump jumphost
	UserKnownHostsFile /etc/ssh/known_hosts
	User $ssh_user
EOL
fi

}

configure_ssh_config
ssh-keyscan 139.59.11.116 >> ${SSH_DIR}/known_hosts


cat ${SSH_DIR}/known_hosts

cd ${SSH_DIR}

ls
# echo "$PRIVATE_KEY" | tr -d '\r' > "$SSH_DIR/id_ed25519"
# chmod 600 "$SSH_DIR/id_ed25519"
# eval "$(ssh-agent -s)"
# ssh-add "$SSH_DIR/id_ed25519"

rsync -av $GITHUB_WORKSPACE/example.txt root@139.59.11.116:/tmp/