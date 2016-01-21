wget -O- https://www.noip.com/client/linux/noip-duc-linux.tar.gz | tar xzvf - noip-2.1.9-1/binaries/noip2-x86_64  -O >/tmp/noip
sudo mv /tmp/noip /usr/bin/noip
sudo chmod +x /usr/bin/noip
sudo noip -C -Ieth0
if ! grep noip /etc/rc.d/rc.local
then echo /usr/bin/noip | sudo tee -a /etc/rc.d/rc.local
fi
