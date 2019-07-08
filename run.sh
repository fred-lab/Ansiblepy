#!/bin/sh

# Init playbook
ansible-playbook -i hosts raspberry/init.yml --vault-password-file .vault_pass --flush-cache