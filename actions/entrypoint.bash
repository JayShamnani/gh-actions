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

echo "$PRIVATE_KEY" >> "$SSH_DIR/id_ed25519"
chmod 600 "$SSH_DIR/id_ed25519"
# eval "$(ssh-agent -s)"
# ssh-add "$SSH_DIR/id_ed25519"

rsync -av $GITHUB_WORKSPACE/example.txt root@139.59.11.116:/tmp/