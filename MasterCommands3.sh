#!/bin/bash
sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
cd /tmp
sudo curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > install-helm.sh
sudo chmod u+x install-helm.sh
./install-helm.sh
sudo helm init --upgrade
sudo kubectl create serviceaccount --namespace kube-system tiller
sudo kubectl create clusterrolebinding tiller-cluster-rule \
   --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
sudo kubectl patch deploy --namespace kube-system tiller-deploy \
   -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
sudo kubectl create -f  /home/ubuntu/TestingLinux/mariadb-hostpath.yaml
sudo kubectl create -f  /home/ubuntu/TestingLinux/wordpress-hostpath.yaml
sudo kubectl create -f /home/ubuntu/TestingLinux/wordpress-mariadb-pvc.yaml 
sudo kubectl create -f /home/ubuntu/TestingLinux/wordpress-pvc.yaml
sudo helm install --name wordpress \
  --set wordpressUsername=admin,wordpressPassword=adminpassword,mariadb.mariadbRootPassword=secretpassword,persistence.existingClaim=wordpress-wordpress,allowEmptyPassword=false \
    stable/wordpress
