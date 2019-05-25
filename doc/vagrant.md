# Development Environment with Vagrant

> If you are running on a system without native docker and docker compose then this approach is relevant for you.

## Requirements

1. Virtualbox
2. Vagrant

## Virtual Machine Setup

Setup virtual machine with `Vagrant` after cloning the repository.

```
vagrant up
```

> This will setup the VM with `docker` and `docker-compose`

If you get an error related to port mapping, open `Vagrantfile` and fix the config related to `forwarded_port`.

SSH login to the virtual machine and access the code base from inside the VM

```
vagrant ssh
cd /vagrant
```

At this point, you are inside the VM with your current directory mapped in VM under `/vagrant`. Follow the [Developer Environment Setup with Docker Compose](developer-guide-docker-compose.md) to get started with the app.

## Reference

* https://www.virtualbox.org/wiki/Downloads
* https://www.vagrantup.com/docs/installation/