# DEMO

## Description

In this demo, we will setup the following hardware:
* 3 physical machines using RPI5's.

Two will be servers, and one will be an agent only

The following services will be setup
* 2 x SPIRE Servers in an HA configuration
* 2 x SSH Host signing service

## Hardware

See hardware list at https://github.com/spiffe/spire/issues/5206

## Base image

Read this whole section before proceeding.

Follow the instructions at https://github.com/AlmaLinux/bootc-images-rpi to setup an initial bootable machine with OS.

Use a rpi-10 based image, not kitten.

## Login

You can either use the console, or ssh in.

## Become root

```
sudo su -
```

## Switch to the spire-setup image

This image provides some tools to help setup your system

Run:
```
bootc switch ghcr.io/spiffe/bootc:almalinux-10-rpi-spire-setup --apply
```

After the reboot, relogin and become root again

```
sudo su -
```

Consider editing /etc/spiffe/default-trust-domain.env and changing the trust domain from example.org to one for your system:
```
vi /etc/spiffe/default-trust-domain.env
```

### Provision TPM for server nodes

If the system is going to be a spire-server and havent ever set up the tpm for this, setup a key for it as described here:
https://github.com/spiffe/spire-server-attestor-tpm?tab=readme-ov-file#setup

Do server `a` and `b` before any other nodes.

### Configure the system
If a SPIRE server `a`:
```
setup-simple-ha-server a
```

Or SPIRE server `b`, run:
Run:
```
setup-simple-ha-server b
```

For any machine, run:
```
setup-static-ip <insert the ip address for this machine here (ex: 192.168.0.10)>
setup-etc-hosts <IP of server A> <IP of server B>
reboot
```

### After getting both servers provisioned, sync the keys from /etc/spire-server-attestor-tpm/keys/* to all nodes

### Switch server nodes to be servers:
```
bootc switch ghcr.io/spiffe/bootc:almalinux-10-rpi-spire-ha-server --apply
```

### Switch agent nodes to be agents:
```
bootc switch ghcr.io/spiffe/bootc:almalinux-10-rpi-spire-ha-agent --apply
```

### On the servers, login and switch to root

Run:
```
chown almalinux /etc/spire/server/main/manifests/
```

For each TPM, run:
```
touch /etc/spire/server/main/tpm-direct/hashes/<TPM-HASH-HERE>
```

### On your own management machine

Edit in the correct TPM Hash over xxx in files *-node.yaml

scp the files in manifests to the servers under /etc/spire/server/main/manifests/

### Check on trust-sync

On server `a` make sure that spire-trust-sync@b is working by ensuring there is output from:
```
spire-server bundle list -socketPath /var/run/spire/server/sockets/main/private/api.sock
```

On server `b` make sure that spire-trust-sync@a is working by ensuring there is output from:
```
spire-server bundle list -socketPath /var/run/spire/server/sockets/main/private/api.sock
```

### Finish setting up the HA trust doamin

Edit the manifests/*-spire-ha-agent.yaml and uncomment out the section:
```
  federatesWith:
  - spire-ha
```

Resync manifests to both servers
