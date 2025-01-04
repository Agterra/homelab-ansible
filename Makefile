TAGS=""

init:
	git config core.hooksPath gitHooks

encrypt:
	ansible-vault encrypt --vault-password-file .passwords/homelab/password inventory/homelab/group_vars/all/secrets.yml

decrypt:
	ansible-vault decrypt --vault-password-file .passwords/homelab/password inventory/homelab/group_vars/all/secrets.yml

install:
	ansible-playbook -i inventory/homelab/hosts \
		--vault-password-file .passwords/homelab/password \
		--extra-vars "ansible_user=$(USER) ansible_port=$(PORT) domain=$(DOMAIN)" \
		install.yml -K

deploy:
	ansible-playbook -i inventory/homelab/hosts \
		--vault-password-file .passwords/homelab/password \
		--extra-vars "ansible_user=$(USER) ansible_port=$(PORT) domain=$(DOMAIN)" \
		deploy.yml --tags $(TAGS) -K

list:
	ansible-playbook -i inventory/homelab/hosts \
		--vault-password-file .passwords/homelab/password tools.yml \
		--extra-vars "ansible_user=$(USER) ansible_port=$(PORT) domain=$(DOMAIN)" \
		--tags docker -K