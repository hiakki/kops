#!/bin/bash
n=1
cd /root/kube-cluster
while [ $n -le $(cat hosts | grep ' worker' -c) ]
do 
echo worker$n
  if [ $(ssh -o StrictHostKeyChecking=no kube@worker$n -p21 ls | grep -c tricksvibe) -lt 1 ]
  then

    ansible-playbook -i hosts --extra-vars "n=worker$n" configuring_worker_node/configuring_worker_node.yml

  fi

  ansible-playbook -i hosts --extra-vars "n=worker$n" update_workers.yml

  n=$(( $n+1 ))
done
