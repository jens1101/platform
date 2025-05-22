# PXE Server

This server consists of 2 components:

1. The TFTP server which serves a version of IPXE with an embedded boot script.
2. The HTTP server which serves the necessary files to perform an automated net
   install of Debian.

The embedded script of the TFTP server always chain loads the IPXE script thats
served by the HTTP server. In this fashion changes can easily be made to the
boot procedure without having to re-build IPXE.

## Booting

### Manual commands

If your machine already has an IPXE firmware pre-installed then you can run this
command to chainload the installer:

```sh
# BIOS
dhcp && chain tftp://[TFTP IP address]/undionly.kpxe

# EFI
dhcp && chain tftp://[TFTP IP address]/ipxe.efi
```
