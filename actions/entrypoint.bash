#!/bin/bash

apt update

cd $GITHUB_WORKSPACE

ls -al

touch secretFile

echo $PRIVATE_KEY >> secretFile

apt-get install openssh-client -y

ssh -i secretFile root@139.59.11.116