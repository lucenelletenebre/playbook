.PHONY: login ping

login:
	tsh login --proxy=$(TELEPORT) --user $(USER)

ssh.cfg: login
	# generete configuration for ansible
	tsh config > ssh.cfg

hosts: login
	tsh ls --format=json | jq '.[].spec.hostname + ".$(TELEPORT)    ansible_user=root"' > hosts
	# remove " from host file coming from previous comand
	sed -i 's/"//g' hosts

ping: hosts ssh.cfg
	ansible-playbook ansible/test.yaml

update: hosts ssh.cfg
	ansible-playbook ansible/update.yaml