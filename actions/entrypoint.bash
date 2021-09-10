#!/bin/bash

apt update

apt-get install -y rsync

apt-get install -y ssh

cd $GITHUB_WORKSPACE

ls -al

touch secretFile

echo $PRIVATE_KEY >> secretFile


mkdir $HOME/.ssh

SSH_DIR="$HOME/.ssh"

echo "$PRIVATE_KEY" | tr -d '\r' > "$SSH_DIR/id_ed25519"
chmod 600 "$SSH_DIR/id_ed25519"
eval "$(ssh-agent -s)"
ssh-add "$SSH_DIR/id_ed25519"

rsync -avzhp $GITHUB_WORKSPACE/example.txt root@139.59.11.116:/home/jayshamnani