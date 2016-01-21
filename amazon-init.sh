sudo /bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=2048
sudo /bin/chmod 0600 /var/swap.1
sudo /sbin/mkswap /var/swap.1
sudo /sbin/swapon /var/swap.1
