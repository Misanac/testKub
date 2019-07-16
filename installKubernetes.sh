#!/bin/sh

#Install prep
sudo apt-get install curl -y
sudo apt-get install apt-utils -y

# Install Docker
curl -sSL get.docker.com | sh && \
  sudo usermod pi -aG docker

# Disable swap (needs to be off for Kubernetes)
#sudo dphys-swapfile swapoff && \
#  sudo dphys-swapfile uninstall && \
#  sudo update-rc.d dphys-swapfile remove

# Install Kubeadm
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - && \
  echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list && \
  sudo apt-get update -q && \
  sudo apt-get install -qy kubeadm

# Enable cgroups
echo Adding " cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory" to /boot/cmdline.txt

sudo cp /boot/cmdline.txt /boot/cmdline_backup.txt
orig="$(head -n1 /boot/cmdline.txt) cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory"
echo $orig | sudo tee /boot/cmdline.txt

# Required for the Flannel network-addon
sysctl net.bridge.bridge-nf-call-iptables=1

echo Please reboot
