# Homelab Scripts and Configurations

This is a set of scripts and configurations that I use on my home-server or across other linux devices.
I set up a home server to deepen my understanding of concepts learned during university lectures, practice and have fun.
I now host a few services to be independent, have my own space and backups, and because it is enjoyable.
Currently, I'm maintaining it, and periodically adding monitoring and automation scripts, solutions and anything that comes to my mind.   

## Repository structure and presentation
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
- `osquery`: SQL-based system-monitoring tool; in this directory are provided configuration and flag file for the osquery daemon. For further information, please refer to the official documentation (osquery.readthedocs.io/) or repository (`osquery/osquery`).
- `wireguard`: here you can find example configuration files for both wireguard VPN client and server. In the server subdirectory two configuration files are proposed: the first contains rules to only accept packets directed only to the server itself; the second one is more complex, and allows traffic forwarding;
 
 The `ansible` directory is the latest contribution to this repo, it houses a simple playbook to automate the configuration of an eventual homeserver. I included in the playbook the installation of basic packages and configuration of services that I use on my personal server, such as caddy, docker, immich and others. Moreover, I handled a proper SSH configuration, copying the public key and disabling login via password. As next steps, I will deploy a VPN and refine the existing code. 

## Deployment and Execution
### daemons
You can place the `.service` and `.timer` files either in `/etc/systemd/system/`, for _system_ unit files, or in `$HOME/.config/systemd/user`, for _user_ units. Then copy or move the executed commands to whatever location is specified within the `ExecStart` field in the unit file; as a general rule for system services, the best location for executables is `/usr/local/bin/`. 

Finally, run `sudo systemctl daemon-reload` (or `systemctl --user daemon-reload`) to let system detect the new units, and execute `sudo systemctl start <service>` (or, again, `systemctl --user start <service>`) to start you service. For more information regarding systemd visit the `systemctl` manual page. 

### services
First, you need to install the desired tool, then:
- `wireguard`: copy the configuration files in `/etc/wireguard/`, and run `sudo wg-quick up <interface>` (`sudo wg-quick down <interface>`) to activate (deactivate) the wireguard interface. The steps are the exact same for both client and server;
- `osquery`: copy the configurations in `/etc/osqueryd/`, then manage the daemon `osqueryd` with systemd. There is also an interactive console (`osqueryi`) included in the packet, which is worth exploring for debugging and real-time insights;

### ansible
For the ansible playbook I imagined a use case of a brand-new ubuntu server, accessible only via password. I tested it on a vagrant-provisioned virtual environment runing Ubuntu 22.04, but changing the configuration specs works only for real, external servers. You need to change you username and password in `inventory.ini` and `group_vars/all.yml`, and all the environment files, variable and configuration files in the `/roles/*/files/` directories (such as filebrowser configuration, shh-key to copy, Caddyfile...). Then, to provision your server, run: 
```
ansible-playbook playbook.yml -i inventory.ini
```    
If you consider employing this playbook in larger, more serious contexts, it is strongly suggested to perform an additional security step: store all sensitive variables in `group_vars/all.yml` and encrypt the file with Ansible Vault using the following command:
```
ansible-vault encrypt group_vars/all.yml
```

## Future updates and security concerns

In the future I will also add to this repository a log aggregation configuration and monitoring frameworks. 

Please note that the configurations and scripts provided in this repository need to be changed and adapted to your personal environment. The ansible playbook, specifically, is intended to serve as an example, or for small environment, so security is not always properly addressed. Some sensitive data, such as passwords, username or domains, are at the moment stored in clear, as they're meant to be a basic configuration to be later changed by the user. If you are considering to reuse this code, take into these aspects before sharing it or deploying it. 
