# Home Lab Scripts and Configurations

## This is a series of scripts, daemons and configurations I use on my home-server or across my other linux devices.
I started a home server to deepen my understanding of concepts learned during university lectures, practice and have fun.
I now host a few services to be independent, have my own space and backups, and because it is enjoyable.
Currently, I'm maintaining it, and periodically adding monitoring and automation scripts, solutions and anything that comes to my mind.   

### Repository structure
```
.
├── ansible
│   └── homeserver
├── daemons
│   ├── update-services
│   └── update-system
├── README.md
└── services
    ├── osquery
    └── wireguard
        ├── client
        └── server
```

The `daemons` directory includes systemd unit files, timers and executable:
- `update-system`: provides a simple service to update the system;
- `update-services`: contains scripts to update my services, such as immich, filebrowser and vaultwarden;

The `services` directory contains configuration files for self-hosted services, such as:
- `osquery`: SQL-based system-monitoring tool; in this directory are provided configuration and flag file for the osquery daemon. For further information, please visit the official website (osquery.io) or repository (`osquery/osquery`).
- `wireguard`: here you can find example configuration files for both wireguard VPN client and server. In the server subdirectory two configuration files are proposed: the first for contains rules to only accept packets directed only to the server itself; the second one is more complex, and permits traffic forwarding;
 
 The `ansible` directory is the latest contribution to this repo, it houses a simple playbook to automate the configuration of an eventual homeserver. I included in the playbook the installation of basic packages and configuration of services that I use on my personal server myself, such as caddy, docker, immich and other. Moreover, I handled a proper configuration of ssh, copying the public key and disabling login via password. As next steps, I will deploy a VPN and refine the existing code. 

In the future I will also add to this repository a log aggregation configuration and monitoring frameworks. 

Please note that the configurations and scripts provided in this repository need to be changed and adapted to your personal environment. The ansible playbook, specifically, is intended to serve as an example, and security is not always properly addressed. Some sensitive data, such as passwords, username or domains, are at the moment stored in clear, as they're meant to be a basic configuration to be later changed by the user. If you are considering to reuse this code, take into these aspects before sharing it or deploying it. 
