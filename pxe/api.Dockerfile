FROM nixos/nix:2.28.2 AS nix
ARG KERNEL_URL
ARG INITRD_URL
RUN echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf
RUN nix-channel --update
RUN nix profile install nixpkgs#gnused
WORKDIR /netboot
COPY ./installer-flake.nix ./flake.nix
RUN mkdir out
RUN nix build --no-link --print-out-paths \
  .#installer.config.system.build.kernel | \
  xargs -I {} cp "{}/bzImage" ./out/
RUN nix build --no-link --print-out-paths \
  .#installer.config.system.build.netbootRamdisk | \
  xargs -I {} cp "{}/initrd" ./out/
RUN nix build --no-link --print-out-paths \
  .#installer.config.system.build.netbootIpxeScript | \
  xargs -I {} sed \
  -e "s!^kernel bzImage!kernel ${KERNEL_URL}!" \
  -e "s!^initrd initrd!initrd ${INITRD_URL}!" \
  "{}/netboot.ipxe" > ./out/netboot.ipxe

FROM nginx:stable-alpine
COPY --from=nix /netboot/out/ /usr/share/nginx/html
