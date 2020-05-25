#!/bin/bash
sudo kubectl create -f  /home/ubuntu/TestingLinux/mariadb-hostpath.yaml
sudo kubectl create -f  /home/ubuntu/TestingLinux/wordpress-hostpath.yaml
sudo kubectl create -f /home/ubuntu/TestingLinux/wordpress-mariadb-pvc.yaml 
sudo kubectl create -f /home/ubuntu/TestingLinux/wordpress-pvc.yaml
sudo helm install --name wordpress \
  --set wordpressUsername=admin,wordpressPassword=adminpassword,mariadb.mariadbRootPassword=secretpassword,persistence.existingClaim=wordpress-wordpress,allowEmptyPassword=false \
    stable/wordpress
