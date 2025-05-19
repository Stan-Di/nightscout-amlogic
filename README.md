


nano /etc/systemd/system/ns.service

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
