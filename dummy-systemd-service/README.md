# Dummy Systemd Service

Start the service
```bash
sudo systemctl start dummy.service
```

Check the logs of the service
```bash
journalctl -u dummy -f
```

Other commands
```bash
sudo systemctl stop dummy
sudo systemctl enable dummy <- Run on Startup
sudo systemctl disable dummy
sudo systemctl status dummy
```