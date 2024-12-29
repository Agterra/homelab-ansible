TAGS=""

init:
	git config core.hooksPath gitHooks

encrypt:
	ansible-vault encrypt --vault-password-file .passwords/homelab/password inventory/homelab/group_vars/all/secrets.yml

decrypt:
	ansible-vault decrypt --vault-password-file .passwords/homelab/password inventory/homelab/group_vars/all/secrets.yml

install:
	ansible-playbook -i inventory/homelab/hosts --vault-password-file .passwords/homelab/password install.yml -K

deploy:
	ansible-playbook -i inventory/homelab/hosts --vault-password-file .passwords/homelab/password deploy.yml --tags $(TAGS) -K

list:
	ansible-playbook -i inventory/homelab/hosts --vault-password-file .passwords/homelab/password tools.yml --tags docker -K