# SPIRE bootc Images

[![Apache 2.0 License](https://img.shields.io/github/license/spiffe/helm-charts)](https://opensource.org/licenses/Apache-2.0)
[![Development Phase](https://github.com/spiffe/spiffe/blob/main/.img/maturity/dev.svg)](https://github.com/spiffe/spiffe/blob/main/MATURITY.md#development)

A set of build scripts and instructions for building [bootc](https://github.com/bootc-dev/bootc) compatible images.

## Warning

This code is very early in development and is very experimental. Please do not use it in production yet. Please do consider testing it out, provide feedback,
and maybe provide fixes.

## Distro options

### RedHat

#### Prerequisites

See the prerequisites from the following site:

https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/using_image_mode_for_rhel_to_build_deploy_and_manage_operating_systems/introducing-image-mode-for-rhel_using-image-mode-for-rhel-to-build-deploy-and-manage-operating-systems#prerequisites

#### Login

Follow the instructions here for setting up a service account and logging into either docker or podman, depending on which one you plan on using:
https://catalog.redhat.com/software/containers/rhel10/rhel-bootc/6707d29f27f63a06f7873ee2?container-tabs=gti&gti-tabs=registry-tokens

#### Build

Use the build script and set the base image to use.

Example:
```
./build.sh --base registry.redhat.io/rhel10/rhel-bootc:10.0-1751944974
```

### AlmaLinux

Example RPI images:
```
./build.sh --base quay.io/almalinuxorg/almalinux-bootc-rpi:10
```

Example regular images:
```
./build.sh --base quay.io/almalinuxorg/almalinux-bootc:10
```

## Demo System

See the instructions under [demo](demo/README.md)

