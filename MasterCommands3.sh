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
