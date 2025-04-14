FROM pghalliday/tftp

ARG ISO_URL
ARG BOOT_FILE

WORKDIR /var/tftpboot

RUN cat <<EOF > "${BOOT_FILE}"
#!ipxe

dhcp

# TODO: this does work, but not all the way. There is obviously something missing
kernel ${ISO_URL}/casper/vmlinuz
initrd ${ISO_URL}/casper/initrd

boot
EOF
