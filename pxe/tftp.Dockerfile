FROM pghalliday/tftp

ENV BOOT_FILE=boot

WORKDIR /var/tftpboot

RUN cat <<EOF > "$BOOT_FILE"
#!ipxe

dhcp
chain http://boot.ipxe.org/demo/boot.php
EOF
