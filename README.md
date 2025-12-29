## This is a series of scripts, daemons and configurations I use on my home-server or across my other linux devices.
I started a home server to deepen my understanding of concepts learned during university lectures, practice and have fun.
I now host a few services to be independent, have my own space and backups, and because it is enjoyable.
Currently, I'm mantaining it, and evolving it to a more cybersecurity-focused lab, periodically adding monitoring and automation scripts and solutions.   

### Repository structure
```
.
├── daemons
├── fake_rm
├── hide
├── osquery
├── README.md
├── remove_spaces
├── services
└── system-backups
```

In the root directory there are a few easy scripts to make life simpler:
- `fake_rm`: moves files and directories to /tmp so that you can recover in case of mistake;
- `hide`: hides elements specified as arguments;
- `remove_spaces`: removes spaces in file names;
To use them daily, the best way is to add an alias in your home directory 

The `daemons` directory includes systemd unit files, timers and executable:
- `update-system`: provides a simple service to update the system;
- `update-services`: contains scripts to update my services, such as immich, filebrowser and vaultwarden;
- `vaultwarden-monitor`: is a tiny monitoring service that alerts via a telegram, using unofficial python-telegram-bot APIs for new accesses to vaultwarden;
- `network-watchdog`: my home wifi service is very unstable, my server may become unreachable if it fails to reconnect after a network issue. This services looks for connection problems and restart the networking service

In `osquery` are provided the configuration files for the osquery daemon, an SQL-based monitoring service. See `osquery/osquery` for further details.

The `services` directory contains configuration files for self-hosted services, such as:
- vaultwarden;
- filebrowser;
- prometheus;

The scripts in `system-backups` were created to make a backup of Debian 12 files and configurations before upgrading to Debian 13 (Trixie).
The backups are made as suggested in the Debian documentation for upgrading the system.  

Please note that the configurations and scripts provided in this repository may need to be changed and adapted to your personal environment. 
