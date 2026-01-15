## This is a series of scripts, daemons and configurations I use on my home-server or across my other linux devices.
I started a home server to deepen my understanding of concepts learned during university lectures, practice and have fun.
I now host a few services to be independent, have my own space and backups, and because it is enjoyable.
Currently, I'm mantaining it, and evolving it to a more cybersecurity-focused lab, periodically adding monitoring and automation scripts and solutions.   

### Repository structure
```
.
├── daemons
│   ├── update-services
│   │   ├── update-filebrowser.sh
│   │   ├── update_services.service
│   │   ├── update_services.sh
│   │   └── update_services.timer
│   └── update-system
│       ├── update-system.service
│       └── update-system.timer
├── README.md
└── services
    ├── osquery
    │   ├── osquery.conf.example
    │   └── osquery.flags.example
    └── wireguard
        ├── client
        │   └── wg0.conf.example
        └── server
            ├── wg0.conf.example
            └── wg1.conf.example
```

The `daemons` directory includes systemd unit files, timers and executable:
- `update-system`: provides a simple service to update the system;
- `update-services`: contains scripts to update my services, such as immich, filebrowser and vaultwarden;

The `services` directory contains configuration files for self-hosted services, such as:
- `osquery`: SQL-based system-monitoring tool; in this directory are provided configuration and flag file for the osquery daemon. For further information, please visit the official website (osquery.io) or repository (`osquery/osquery`).
- `Wireguard`: here you can find example configuration files for both wireguard VPN client and server. In the server subdirectory two configuration files are proposed: the first for contains rules to only accept packets directed only to the server itself; the second one is more complex, and permits traffic forwarding;
 
Please note that the configurations and scripts provided in this repository need to be changed and adapted to your personal environment. 
