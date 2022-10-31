# Training Support Container

This repository is part of the PostgreSQL training and provides a `docker-compose.yml` file to run [Minio](https://min.io/) and [etcd](https://etcd.io/) with a minimal configuration. A bucket, called `pgbackrest`, is created in Minio at startup.


## Prerequisites

* podman
* podman-compose
* Rockylinux vms of this [repository](https://github.com/dirkcaumueller/training-vms.git) (optional)


## Clone Repository

Clone this repository and change into the created directory.

```bash
git clone https://github.com/dirkcaumueller/training-support-container.git
cd training-support-container
```


## Bootstrap VM

> Run script only when using a Rockylinux vm!

The following steps install required packages, e.g. podman, and opens ports on the vm.

```bash
chmod 744 bootstrap_vm.sh
./bootstrap_vm.sh
```


## Run Containers

Run `podman-compose` to start all containers.

```bash
podman-compose up -d
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
