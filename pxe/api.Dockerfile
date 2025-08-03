FROM nginx:stable-alpine
# The URL from where the installer should fetch the preseed file. This should
# be http://[API IP]/preseed.cfg
ARG PRESEED_URL
# The public SSH key to add to the list of authorized keys. This will be the
# only way to log in to the server.
ARG SSH_PUBLIC_KEY
# The path of the disk that should be formatted and used by the OS.
# Example: /dev/sda
ARG DISK_PATH
# The host name to use for the new system
ARG HOST_NAME
# The name for the logical volume group
ARG VG_NAME

WORKDIR /usr/share/nginx/html

COPY netboot.ipxe template.netboot.ipxe
RUN envsubst '$PRESEED_URL' < template.netboot.ipxe > netboot.ipxe
RUN rm template.netboot.ipxe

COPY preseed.cfg template.preseed.cfg
RUN envsubst '$SSH_PUBLIC_KEY,$DISK_PATH,$HOST_NAME,$VG_NAME' < template.preseed.cfg > preseed.cfg
RUN rm template.preseed.cfg
