#!/bin/bash
ansible-playbook -i hosts installing_kubernetes.yml
ansible-playbook -i hosts creating_user.yml
sh configuring_master_node/configuring_master_node.sh
sh configuring_worker_node/configuring_worker_node.sh
ansible-playbook -i hosts joining_master_node.yml
ansible-playbook -i hosts restart_my_app.yml
