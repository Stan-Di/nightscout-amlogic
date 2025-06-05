#!/bin/sh

apt-get install -y gnupg curl wget
curl -fsSL https://www.mongodb.org/static/pgp/server-4.4.asc | gpg -o /usr/share/keyrings/mongodb-server-4.4.gpg --dearmor
echo "deb [ arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/mongodb-server-4.4.gpg ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.4.list
wget http://ports.ubuntu.com/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_arm64.deb
dpkg -i libssl1.1_1.1.1f-1ubuntu2_arm64.deb

apt update
apt-get install -y mongodb-org=4.4.18 mongodb-org-server=4.4.18 mongodb-org-mongos=4.4.18 mongodb-org-tools=4.4.18 mongodb-org-shell=4.4.18 mongodb-org-database-tools-extra=4.4.18

curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt-get install nodejs -y

wget https://github.com/nightscout/cgm-remote-monitor/archive/refs/tags/15.0.3.tar.gz 
tar xzvf 15.0.3.tar.gz
mv cgm-remote-monitor-15.0.3 cgm
cd cgm
wget https://github.com/Stan-Di/nightscout-amlogic/raw/refs/heads/main/cgm.gz
tar xzvf cgm.gz

npm install

systemctl start mongod
systemctl enable mongod
