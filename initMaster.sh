#!/bin/bash

# Pre-pull the requisites Docker images needed to run a Kubernetes master
kubeadm config images pull -v3

# Init master node
kubeadm init --token-ttl=0 --pod-network-cidr=10.244.0.0/16 # This uses the Flannel pod network addon

# Setup local access to the cluster via the kubectl command
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

# Install the pod network-addon
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
