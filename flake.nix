# Algo's NixOS flake (core file for all config)

{
description = "Core NixOS flake for Melis";

inputs = {
	nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
	catppuccin.url = "github:catppuccin/nix";
	hjem = {
      		url = "github:feel-co/hjem";
      		inputs.nixpkgs.follows = "nixpkgs";
    	};
	home-manager = {
		url = "github:nix-community/home-manager";
		inputs.nixpkgs.follows = "nixpkgs";
	};
	hyprland.url = "github:hyprwm/Hyprland";
	noctalia = {
      		url = "github:noctalia-dev/noctalia";
      		inputs.nixpkgs.follows = "nixpkgs";
    	};
	musnix = { url = "github:musnix/musnix"; };
};

outputs = inputs @ { self, nixpkgs, catppuccin, home-manager, ... }: {
	nixosConfigurations.melis = nixpkgs.lib.nixosSystem {
		specialArgs = { inherit inputs; };
		modules = [
			./configuration.nix
			./hardware-configuration.nix
			./noctalia.nix
			inputs.hjem.nixosModules.default
			./hjem.nix
			catppuccin.nixosModules.catppuccin {
				catppuccin.autoEnable = true;
				catppuccin.enable = true;
				catppuccin.flavor = "mocha";
				catppuccin.accent = "pink";
			}
			inputs.musnix.nixosModules.musnix
			home-manager.nixosModules.home-manager {
            			home-manager.useGlobalPkgs = true;
            			home-manager.useUserPackages = true;
				home-manager.backupFileExtension = "bkp";
				home-manager.overwriteBackup = true;
				home-manager.users.algo = {
					imports = [ ./home.nix ];
				};
			}
		];
	};
};

}

