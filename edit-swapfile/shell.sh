# execute in terminal

# show current swapfile
swapon -s
# disable swapfile
sudo swapoff -a
# increase swapfile to 32GB
sudo dd if=/dev/zero of=/swapfile bs=1M count=32768
sudo mkswap /swapfile
