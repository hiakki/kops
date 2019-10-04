#!/bin/bash
n=1
while [ $n -le $(cat kube-cluster/hosts | grep ' master' -c) ]
do 
  echo master$n
  if [ $(ssh -o StrictHostKeyChecking=no kube@master -p21 'kubectl get deploy -n=kube-system' | grep metrics-server -c) -lt 1 ]
  then
    echo  a
    ansible-playbook -i kube-cluster/hosts --extra-vars "n=$n" kube-cluster/configuring_master_node/configuring_master_node.yml
  fi
  echo Master$n is setup.
  n=$(( $n+1 ))
done
