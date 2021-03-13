#!/bin/bash
sudo cp $1 /etc/systemd/system/
sudo systemctl daemon-reload
read -p "Install and Start the service? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	sudo systemctl start $1
	sudo systemctl enable $1
fi