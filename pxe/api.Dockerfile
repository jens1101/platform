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
# Amount of volume group to use for guided partitioning. It can either be a size
# with its unit (eg. 20 GB), a percentage of free space or the 'max' keyword.
ARG MAIN_PARTITION_SIZE
# The hostname for the Debian mirror from which Debian will be downloaded.
# Responses from this mirror will be cached using Nginx.
ARG DEBIAN_MIRROR_HOST

ENV DEBIAN_MIRROR_URL="http://${DEBIAN_MIRROR_HOST}"

WORKDIR /etc/nginx/conf.d

# Copy config for caching proxy of Debian mirror
COPY nginx-debian-cache.conf template.nginx-debian-cache.conf
RUN envsubst '$DEBIAN_MIRROR_URL,$DEBIAN_MIRROR_HOST' \
  < template.nginx-debian-cache.conf \
  > nginx-debian-cache.conf
RUN rm template.nginx-debian-cache.conf

WORKDIR /usr/share/nginx/html

# Copy config for iPXE netboot of Debian installer
COPY netboot.ipxe template.netboot.ipxe
RUN envsubst '$PRESEED_URL,$DEBIAN_MIRROR_URL' \
  < template.netboot.ipxe \
  > netboot.ipxe
RUN rm template.netboot.ipxe

# Copy config for unattended Debian installer
COPY preseed.cfg template.preseed.cfg
RUN envsubst '$SSH_PUBLIC_KEY,$DISK_PATH,$HOST_NAME,$VG_NAME,\
  $MAIN_PARTITION_SIZE,$DEBIAN_MIRROR_HOST' \
  < template.preseed.cfg \
  > preseed.cfg
RUN rm template.preseed.cfg
