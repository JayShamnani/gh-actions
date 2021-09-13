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

echo "Creating KEY"

# echo "$PRIVATE_KEY" | tr -d '\r' > "$SSH_DIR/id_ed25519"
# chmod 600 "$SSH_DIR/id_ed25519"
# eval "$(ssh-agent -s)"
# ssh-add "$SSH_DIR/id_ed25519"

echo "$PRIVATE_KEY" | tr -d '\r' > "$SSH_DIR/id_ed25519"
chmod 600 "$SSH_DIR/id_ed25519"
eval "$(ssh-agent -s)"
ssh-add "$SSH_DIR/id_ed25519"


cat > /etc/ssh/ssh_config <<EOL
Host *
User root
UserKnownHostsFile ${SSH_DIR}/known_hosts
EOL

ssh-keyscan "${1##*@}" >> ${SSH_DIR}/known_hosts

echo "KEY created"

cat example.txt

rsync -avzhp -e "ssh -i $HOME/.ssh/id_ed25519" example.txt root@139.59.11.116:/public/