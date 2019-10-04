#!/bin/bash
n=1
while [ $n -le $(cat kube-cluster/hosts | grep ' worker' -c) ]
do 
echo worker$n
  if [ $(ssh -o StrictHostKeyChecking=no kube@worker$n -p21 ls | grep -c tricksvibe) -lt 1 ]
  then

    ansible-playbook -i kube-cluster/hosts --extra-vars "n=worker$n" kube-cluster/configuring_worker_node/configuring_worker_node.yml

  fi

  ansible-playbook -i kube-cluster/hosts --extra-vars "n=worker$n" kube-cluster/update_workers.yml

  n=$(( $n+1 ))
done
