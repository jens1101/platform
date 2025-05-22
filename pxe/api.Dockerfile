FROM nginx:stable-alpine
ARG PRESEED_URL
ARG SSH_PUBLIC_KEY
WORKDIR /usr/share/nginx/html

COPY netboot.ipxe template.netboot.ipxe
RUN envsubst '$PRESEED_URL' < template.netboot.ipxe > netboot.ipxe
RUN rm template.netboot.ipxe

COPY preseed.cfg template.preseed.cfg
RUN envsubst '$SSH_PUBLIC_KEY' < template.preseed.cfg > preseed.cfg
RUN rm template.preseed.cfg
