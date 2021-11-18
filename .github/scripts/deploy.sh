#!/bin/sh

mkdir ~/.ssh

echo $VAULT_PASS > ~/vault_passowrd_file.txt

ansible-vault decrypt \
  --vault-password-file=~/vault_passowrd_file.txt .github/actions/deploy/id_rsa_encrypted \
  --output=~/.ssh/id_rsa

rm ~/vault_passowrd_file.txt

chmod 0600 ~/.ssh/id_rsa
chmod 0700 ~/.ssh

ssh -T -v -i ~/.ssh/id_rsa -o StrictHostKeyChecking=accept-new -C ubuntu@54.229.62.246 "cat /etc/lsb-release"

cat ~/.ssh/known_hosts

ansible-playbook -u ubuntu -i .github/ansible/hosts.ini .github/ansible/deploy.yml