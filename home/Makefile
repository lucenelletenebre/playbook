.PHONY: login ping

login:
	tsh login --proxy=$(TELEPORT) --user $(USER)

ssh.cfg: login
	# generete configuration for ansible
	tsh config > ssh.cfg

ping:
	ansible-playbook ansible/test.yaml