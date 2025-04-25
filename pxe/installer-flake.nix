{
  description = "Netboot unattended installer";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
  };

  outputs = { nixpkgs, ... }@inputs: {
    installer = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs; };
      modules = [
        ({pkgs, modulesPath, ...}: {
          imports = [
            "${modulesPath}/installer/netboot/netboot-minimal.nix"
          ];

          nixpkgs.hostPlatform = "x86_64-linux";
          system.stateVersion = "24.11";
        })
      ];
    };
  };
}
