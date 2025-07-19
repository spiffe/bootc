# DEMO

## Hardware

See hardware list at https://github.com/spiffe/spire/issues/5206

## Base image

Follow the instructions at https://github.com/AlmaLinux/bootc-images-rpi to setup an initial bootable machine with OS.

Don't boot the image yet though.

## Customize the install

Edit the user-data file and add the following to the end, changing example.org to whatever trust domain you wish to use:
```
write_files:
  - path: /etc/spiffe/default-trust-domain.env
    content: |
      SPIFFE_TRUST_DOMAIN=example.org
    owner: root:root
    permissions: '0644'
```
