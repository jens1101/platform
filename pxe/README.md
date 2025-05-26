# PXE Server

This server is used to automatically install a minimal version of Debian
on a target machine via the network. The intention is to easily wipe a physical
or virtual machine in preparation for a greater server setup.

**⚠️ Warning:** All data on the specified device will be wiped without
confirmation.

The Debian installer will set up a single user, `debian`. Root and password
login are both disabled and login is only possible via SSH.

---

This server consists of 3 components:

1. A TFTP server which serves a version of IPXE with an embedded boot script
2. A HTTP server which serves the necessary files to perform an automated net
   install of Debian
3. _(Optional)_ A DHCP server to generate the appropriate responses for net
   booting

The embedded script of the TFTP server always chain loads the IPXE script thats
served by the HTTP server. In this fashion changes can easily be made to the
boot procedure without having to re-build IPXE.

## Booting

Before following any of these guides be sure to:

1. Copy `.sample.env` to `.env`
2. Update the environment variables for what is appropriate in your setup
3. The target machine will have internet connectivity

Any changes to the environment variables will require a rebuild.

### Automated with your own DHCP server

1. Update your DHCP server to point to the necssary files on the TFTP server
   - BIOS: `[TFTP IP address]/undionly.kpxe`
   - EFI: `[TFTP IP address]/ipxe.efi`
2. Start the Docker services:
   ```sh
   docker compose up --build
   ```
3. Start the target machine. It should get an address from the DHCP server and
   begin the netboot process.

### Automated with the provided DHCP server

1. Be sure that there are no other DHCP servers on your network. There's nothing
   preventing multiple DHCP servers from running on a network and it can cause
   unpredictable results.
2. Start the Docker services:
   ```sh
   docker compose -f docker-compose.yml -f dhcp.docker-compose.yml up --build
   ```
3. Start the target machine. It should get an address from the DHCP server and
   begin the netboot process.

### Manual boot

If your machine already has an IPXE firmware pre-installed then you can manually
chain load this installer without having to touch the DHCP setup.

1. Start the Docker services:
   ```sh
   docker compose up --build
   ```
2. Start your machine and enter the IPXE command line
3. Run one of these commands to begin the netboot process:

   ```sh
   # BIOS
   dhcp && chain tftp://[TFTP IP address]/undionly.kpxe

   # EFI
   dhcp && chain tftp://[TFTP IP address]/ipxe.efi
   ```
