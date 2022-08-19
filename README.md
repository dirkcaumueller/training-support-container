# Training Support Container

This repository is part of the PostgreSQL training and provides a docker compose file to run [Minio](https://min.io/) and [etcd](https://etcd.io/) with a minimal configuration within a vm. A bucket, called `pgbackrest`, is created in Minio at startup.


## Prerequisites

* Rockylinux 8/9 vms of this [repository](https://github.com/dirkcaumueller/training-vms.git)
* Docker
* Docker compose plugin

> The content and following steps of this repository are to be installed on the vm named `server0` (IP: 
> 192.168.56.200).


## Install Docker

The following steps install docker on the vm.

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


## Check Minio & etcd

Check Minio by navigating to the web interface. Login with these credentials:

* username: `minio`
* password: `minio123`

> The IP might differ with each setup. This example is based on running the containers within a VM with 
> the IP `192.168.56.200`.

```bash
http://192.168.56.200:9001
```

Show the health of the etcd cluster.

```bash
ETCDCTL_API=3 etcdctl --endpoints 192.168.56.200:23790,192.168.56.200:23791,192.168.56.200:23792 endpoint health
```

Show the etcd cluster members.

```bash
ETCDCTL_API=3 etcdctl --endpoints 192.168.56.200:23790,192.168.56.200:23791,192.168.56.200:23792 member list
```


## License

MIT


## Author Information

Authors:

* Dirk Aumueller
