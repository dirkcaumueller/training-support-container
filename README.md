# Training Support Container

This repository is part of the PostgreSQL training and provides a docker compose file to run [Minio](https://min.io/) and [etcd](https://etcd.io/) with a minimal configuration. A bucket, called `pgbackrest`, is created in Minio at startup.


## Prerequisites

* Docker
* Docker compose plugin

> 


## Install Docker

The following steps install docker on Rockylinux 8/9.

```bash
sudo dnf -y -q remove docker docker-common docker-selinux docker-engine
sudo dnf -y -q config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf -y -q update
sudo dnf -y -q install device-mapper-persistent-data lvm2
sudo dnf -y -q install docker-ce docker-ce-cli containerd.io docker-compose-plugin #--allowerasing
```

Start the docker service and enable start on boot.

```bash
sudo systemctl start docker
sudo systemctl enable docker
```

Add user, e.g. `vagrant` to `docker` group.

```bash
sudo usermod -aG docker vagrant
```


## Open Ports

Open the required firewall ports for Minio.

```bash
sudo firewall-cmd --zone=public --add-port=9000/tcp --permanent
sudo firewall-cmd --zone=public --add-port=9001/tcp --permanent
```

Open firewall ports for etcd.

```bash
sudo firewall-cmd --zone=public --add-port=23800/tcp --permanent
sudo firewall-cmd --zone=public --add-port=23801/tcp --permanent
sudo firewall-cmd --zone=public --add-port=23802/tcp --permanent
sudo firewall-cmd --zone=public --add-port=23790/tcp --permanent
sudo firewall-cmd --zone=public --add-port=23791/tcp --permanent
sudo firewall-cmd --zone=public --add-port=23792/tcp --permanent
```

Finally, reload the firewall.

```bash
sudo firewall-cmd --reload
```


## Run Containers

Clone this repository and change into the created directory.

```bash
git clone https://github.com/dirkcaumueller/training-support-container.git
```

Run docker compose file to start all containers.

```bash
docker compose up -d
```


## License

MIT


## Author Information

Authors:

* Dirk Aumueller
