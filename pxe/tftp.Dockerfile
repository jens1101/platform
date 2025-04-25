FROM alpine:3 AS ipxe
ARG BOOT_URL
ARG COMMIT_SHA
RUN apk add --no-cache git build-base perl xz xz-dev mtools
RUN mkdir /ipxe
WORKDIR /ipxe
# IPXE for some reason abandoned tagging their code years ago. This means that
# builds can fail every time a new commit is pushed. To avoid this we always
# build from a known goot commit.
RUN git clone https://github.com/ipxe/ipxe.git . && git reset --hard ${COMMIT_SHA}
WORKDIR /ipxe/src
RUN cat <<EOF > "boot.ipxe"
#!ipxe
dhcp
chain --replace ${BOOT_URL}
EOF
RUN make bin-x86_64-pcbios/undionly.kpxe bin-x86_64-efi/ipxe.efi EMBED=boot.ipxe

FROM pghalliday/tftp
ARG LEGACY_BOOT_FILE=undionly.kpxe
ARG EFI_BOOT_FILE=ipxe.efi
WORKDIR /var/tftpboot
COPY --from=ipxe /ipxe/src/bin-x86_64-pcbios/undionly.kpxe ./${LEGACY_BOOT_FILE}
COPY --from=ipxe /ipxe/src/bin-x86_64-efi/ipxe.efi ./${EFI_BOOT_FILE}
