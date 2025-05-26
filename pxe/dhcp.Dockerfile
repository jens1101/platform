FROM networkboot/dhcpd
ARG SUBNET_IP
ARG SUBNET_MASK
ARG DHCP_POOL_MIN_IP
ARG DHCP_POOL_MAX_IP
ARG GATEWAY_IP
ARG TFTP_IP

RUN apt-get -q -y update \
  && apt-get -q -y install gettext \
  && apt-get -q -y autoremove \
  && apt-get -q -y clean \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /data

COPY dhcpd.conf template.dhcpd.conf
RUN envsubst < template.dhcpd.conf > dhcpd.conf
RUN rm template.dhcpd.conf
