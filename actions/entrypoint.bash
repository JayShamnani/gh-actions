#!/bin/bash

apt update

cd $GITHUB_WORKSPACE

ls -al

touch secretFile

echo $PRIVATE_KEY >> secretFile

apt-get install openssh-client -y

apt-get install rsync -y

SSH_DIR="$HOME/.ssh"

echo "$PRIVATE_KEY" | tr -d '\r' > "$SSH_DIR/id_ed25519"
chmod 600 "$SSH_DIR/id_ed25519"
eval "$(ssh-agent -s)"
ssh-add "$SSH_DIR/id_ed25519"

rsync -avzhp $GITHUB_WORKSPACE/example.txt root@139.59.11.116:/home/jayshamnani