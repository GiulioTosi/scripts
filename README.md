# Homelab Scripts and Configurations

This is a set of scripts and configurations that I use on my home-server or across other Linux devices.
I set up a home server to deepen my understanding of concepts learned during university lectures, practice and have fun.
I now host a few services to be independent, have my own space and backups, and simply because I enjoy it.
Currently, I'm maintaining it, and periodically adding monitoring and automation scripts, solutions and anything that comes to my mind.   

## Repository structure and presentation
```
.
├── ansible
│   └── homeserver
├── daemons
│   ├── nas-backup
│   ├── update-services
│   └── update-system
├── README.md
├── services
│   ├── osquery
└── └── wireguard
```

The `daemons` directory includes systemd unit files, timers and executable:
- `update-system`: provides a simple service to update the system;
- `update-services`: contains scripts to update my services, such as immich, filebrowser and vaultwarden;
- `nas-backup`: in this directory there is a script, with the associated systemd service and timer, to backup some important folders of my server on an external HDD;

The `services` directory contains configuration files for self-hosted services, such as:
- `osquery`: SQL-based system-monitoring tool; this directory provides configuration and flag files for the osquery daemon. For further information, please refer to the official documentation (osquery.readthedocs.io/) or repository (`osquery/osquery`);
- `wireguard`: here you can find example configuration files for both wireguard VPN client and server. In the server subdirectory two configuration files are proposed: the first contains rules to accept packets directed only to the server itself; the second one is more complex, and allows traffic forwarding;
 
 The `ansible` directory is the latest contribution to this repo, it houses a simple playbook to automate the configuration of an eventual homeserver. I included in the playbook the installation of basic packages and configuration of services that I use on my personal server, such as caddy, docker, immich and others. Moreover, I handled a proper SSH configuration, copying the public key and disabling login via password. As next steps, I will deploy a VPN and refine the existing code. 

## Deployment and Execution
### Daemons
You can place the `.service` and `.timer` files either in `/etc/systemd/system/`, for _system_ unit files, or in `$HOME/.config/systemd/user`, for _user_ units. Then copy or move the corresponding executables to the location specified in the `ExecStart` field in the unit file; as a general rule for system services, the best location for executables is `/usr/local/bin/`. 

Finally, run `sudo systemctl daemon-reload` (or `systemctl --user daemon-reload`) to let the system detect the new units, and execute `sudo systemctl start <service>` (or, again, `systemctl --user start <service>`) to start you service. For more information regarding systemd visit the `systemctl` manual page. 

### Services
First, you need to install the desired tool, then:
- `wireguard`: copy the configuration files in `/etc/wireguard/`, and run `sudo wg-quick up <interface>` (`sudo wg-quick down <interface>`) to activate (deactivate) the wireguard interface. The steps are the exact same for both client and server;
- `osquery`: copy the configurations in `/etc/osqueryd/`, then manage the daemon `osqueryd` with systemd. There is also an interactive console (`osqueryi`) included in the package, which is worth exploring for debugging and real-time insights;

### Ansible
This is an amateur playbook, built for my personal home server. It is mainly intended to demonstrate the use of Ansible to provision a small server, rather than to provide a distribution-independent production role. I tested it on a Vagrant-provisioned Ubuntu 22.04 virtual machine and use it on a Debian server.

The current target is **amd64 Debian or Debian-derived systems** (such as Ubuntu), with `systemd`, a working network connection, and an account that can access superuser privileges. Other operating systems and architectures are not supported. 

The example inventory contains Vagrant credentials for local testing. They are intentionally simple and must be replaced when targeting another machine. In particular, adapt the files and variables in `group_vars/` and `/roles/*/files/` (SSH keys, environment files, and Caddyfile). Then provision your server running:
```
ansible-playbook playbook.yml -i inventory.ini
```    
If you reuse this playbook in a less controlled environment, store sensitive variables outside the repository or encrypt them with Ansible Vault, for example:
```
ansible-vault encrypt group_vars/all.yml
```

>  **⚠️ Note:** The SSH role first installs the configured public keys and then disables password authentication. Before using it on a remote server, verify that the key and target user are correct and keep an existing session open until key-based login has been tested.

## Future updates and security concerns

- In the future I will also add to this repository a log aggregation configuration and monitoring frameworks;
- Filebrowser has been removed, as it has been discontinued, and it'll be replaced with filebrowser-quantum as soon as possible;
- Migrate from Caddy to nginx;

Please note that the configurations and scripts provided in this repository need to be changed and adapted to your personal environment. The ansible playbook, specifically, is intended to serve as an example, or for small personal environment, so security is not always properly addressed. Some sensitive data, such as passwords, username or domains, are at the moment stored in clear, as they're meant to be a basic configuration to be later changed by the user. If you plan to reuse this code, take into these aspects before sharing it or deploying it. 
