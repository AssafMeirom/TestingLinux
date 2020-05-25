#!/bin/bash
sudo kubectl create -f  /home/ubuntu/mariadb-hostpath.yaml
sudo kubectl create -f  /home/ubuntu/wordpress-hostpath.yaml
sudo kubectl create -f /home/ubuntu/wordpress-mariadb-pvc.yaml 
sudo kubectl create -f /home/ubuntu/wordpress-pvc.yaml
sudo helm install --name wordpress \
  --set wordpressUsername=admin,wordpressPassword=adminpassword,mariadb.mariadbRootPassword=secretpassword,persistence.existingClaim=wordpress-wordpress,allowEmptyPassword=false \
    stable/wordpress