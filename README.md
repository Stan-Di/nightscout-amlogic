### Launch Nightscout (cgm-remote-monitor) with MongoDB 4.4 on your Android TV box with Amlogic CPU

If you have an unnecessary TV box with an Amlogic S905, S905L-3, S905W, S905W2, S905X, S905X2,S905X3, S905X4, S905Y4, S912 or S922X CPU, you can install Ubuntu on a microSD card according to instruction here
https://github.com/devmfc/debian-on-amlogic

After starting the Ubuntu system with a configured Internet connection run console command
```
apt update -y && apt install -y curl && curl -Lso- https://raw.githubusercontent.com/Stan-Di/nightscout-amlogic/refs/heads/main/install.sh | sh
```
Script will install MongoDB 4.4.18 from old Focal MongoDB repository, NodeJS 18 (working with Nightscout 15.0.3) from repository and Nightscout 15.0.3 from https://github.com/nightscout/cgm-remote-monitor/releases/tag/15.0.3

### Add Nightscout service to Systemctl

nano /etc/systemd/system/ns.service
```
[Unit]
Description=Nightscout Service 1337
After=network.target

[Service]
Type=simple
WorkingDirectory=/root/cgm
ExecStart=/root/cgm/start.sh 1337
Restart=on-failure

[Install]
WantedBy=multi-user.target
```
After this
```
systemctl start ns
systemctl enable ns
```

### To run other Nightscouts you can add other nsN.service and change the port as an example:

nano /etc/systemd/system/ns1.service
```
[Unit]
Description=Nightscout Service 13370
After=network.target

[Service]
Type=simple
WorkingDirectory=/root/cgm
ExecStart=/root/cgm/start.sh 13370
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

```
systemctl start ns1
systemctl enable ns1
```
On Tv Box with 2gb RAM work fine 11 Nightscout

### Editing Nightscout settings

Instructions for setting up variables are on the official website - https://github.com/nightscout/cgm-remote-monitor?tab=readme-ov-file#environment

For edit, cd to home directory (/root/) and run
```
nano cgm/env/1337.env
```
Save variables (Ctrl-X and type y) and restart Nightscout server
```
pkill node
```
For other Nightscout instances, create and edit files 13370.env, 13371.env, etc... in the directory cgm/env. Here 13370, 13371 - is the port number new instance of Nightscout. I use numbers 1337*, 2337*, 3337* 
for convenience.

### Bonus: Access to your Nightscout using Cloudflared

To test access your Nightscout install and run cloudflared - https://github.com/cloudflare/cloudflared
```
wget https://github.com/cloudflare/cloudflared/releases/download/2025.5.0/cloudflared-linux-arm64.deb
dpkg -i cloudflared-linux-arm64.deb
cloudflared tunnel --url localhost:1337
```
You can see as example
```
2025-05-22T07:46:43Z INF Requesting new quick Tunnel on trycloudflare.com...
2025-05-22T07:46:49Z INF +--------------------------------------------------------------------------------------------+
2025-05-22T07:46:49Z INF |  Your quick Tunnel has been created! Visit it at (it may take some time to be reachable):  |
2025-05-22T07:46:49Z INF |  https://warranty-y-schema-perfume.trycloudflare.com                                       |
2025-05-22T07:46:49Z INF +--------------------------------------------------------------------------------------------+
```
There https://warranty-y-schema-perfume.trycloudflare.com is your tempotary address.

In advanced mode you can add your domain name to Cloudflare Zero Trust and create Tunnel with TV box - https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/get-started/create-remote-tunnel/
