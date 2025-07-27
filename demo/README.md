# DEMO

## Hardware

See hardware list at https://github.com/spiffe/spire/issues/5206

## Base image

Read this whole section before proceeding.

Follow the instructions at https://github.com/AlmaLinux/bootc-images-rpi to setup an initial bootable machine with OS.

Use a rpi-10 based image, not kitten.

## Login

You can either use the console, or ssh in.

## Switch to the spire-setup image

This image provides some tools to help setup your system

Run:
```
bootc switch ghcr.io/spiffe/bootc:almalinux-10-rpi-spire-setup --apply
```

After the reboot and relogin

Consider editing /etc/spiffe/default-trust-domain.env and changing the trust domain from example.org to one for your system:
```
vi /etc/spiffe/default-trust-domain.env
```

### Configure the system
Run:
```
setup-static-ip <insert the ip address for this machine here (ex: 192.168.0.10)>
setup-tpm
reboot
```

### Test the TPM and get its pubhash
After the reboot, relogin and run:
```
get-tpm-pubhash
```

If everything is working, you should see something like:
```
5d3a79210d1fefc26de9c9480e544a1097e0d8cc0499dc89b6496aaba3b9e011
```

Take note of the value for your system. We will need it later.

### Provision TPM for server nodes

If the system is going to be a spire-server and havent ever set up the tpm for this, setup a key for it as described here:
https://github.com/spiffe/spire-server-attestor-tpm?tab=readme-ov-file#setup

