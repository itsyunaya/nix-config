{
	description = "ashley/itsyunaya personal nixos config flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

		# https://github.com/nix-darwin/nix-darwin
		nix-darwin = {
			url = "github:LnL7/nix-darwin";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# https://github.com/nixos/nixos-hardware
		nixos-hardware = {
			url = "github:NixOS/nixos-hardware";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# https://github.com/ryantm/agenix
		agenix = {
			url = "github:ryantm/agenix";
			inputs.nixpkgs.follows = "nixpkgs";
			inputs.darwin.follows = "";
		};

		# https://github.com/itsyunaya/ags-bar
		ags-bar = {
			url = "github:itsyunaya/ags-bar";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# https://github.com/itsyunaya/alejandra-opinionated
		alejandra = {
			url = "github:itsyunaya/alejandra-opinionated";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# https://codeberg.org/LGFae/awww
		awww = {
			url = "git+https://codeberg.org/LGFae/awww";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# https://github.com/feel-co/hjem
		hjem = {
			url = "github:feel-co/hjem";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# https://github.com/hyprwm/Hyprland
		hyprland.url = "github:hyprwm/Hyprland";

		# https://github.com/Gerg-L/mnw
		mnw.url = "github:Gerg-L/mnw";

		# https://github.com/itsyunaya/musicpresence-flake
		musicpresence = {
			url = "github:itsyunaya/musicpresence-flake";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# https://github.com/kossLAN/qtengine
		qtengine = {
			url = "github:kossLAN/qtengine";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# https://github.com/Gerg-L/spicetify-nix/
		spicetify-nix = {
			url = "github:Gerg-L/spicetify-nix/";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# https://github.com/itsyunaya/xwl-notifier-rs
		#xwl-notifier = {
		#	url = "github:itsyunaya/xwl-notifier-rs";
		#	inputs.nixpkgs.follows = "nixpkgs";
		#};

		# https://github.com/0xc000022070/zen-browser-flake
		zen-browser = {
			url = "github:0xc000022070/zen-browser-flake";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = inputs @ {
		self,
		nixpkgs,
		nix-darwin,
		nixos-hardware,
		agenix,
		ags-bar,
		alejandra,
		hjem,
		mnw,
		musicpresence,
		qtengine,
		spicetify-nix,
		...
	}: let
		alejandra-overlay = final: prev: {
			alejandra = alejandra.packages.${prev.stdenv.hostPlatform.system}.default;
		};

		tackInputs = import ./.tack;

		mkHost = { system, modules, overlays ? [], workstation ? false }: let
			sysFn =
				if system == "aarch64-darwin"
				then nix-darwin.lib.darwinSystem
				else nixpkgs.lib.nixosSystem;
			pkgs = import nixpkgs { inherit system overlays; };
		in
			sysFn {
				inherit system;
				modules = modules ++ [ { nixpkgs.overlays = overlays; } ];

				specialArgs = {
					inherit inputs self tackInputs;
					theme =
						if workstation
						then import ./theme.nix { inherit self; }
						else null;
					fnLib = import ./lib/default.nix { inherit self pkgs; };
				};
			};
	in {
		nixosConfigurations."juno" = mkHost {
			system = "x86_64-linux";
			workstation = true;

			overlays = [
				alejandra-overlay
				musicpresence.overlays.default
				tackInputs.xwl-notifier.overlays.default
			];

			modules = [
				./hosts/juno/configuration.nix

				hjem.nixosModules.default
				mnw.nixosModules.mnw
				nixos-hardware.nixosModules.msi-b550-a-pro
				qtengine.nixosModules.default
				spicetify-nix.nixosModules.spicetify
			];
		};

		darwinConfigurations."ashleys-macbook-pro" = mkHost {
			system = "aarch64-darwin";
			workstation = true;

			overlays = [
				alejandra-overlay
				musicpresence.overlays.default
			];

			modules = [
				./hosts/ashleys-macbook-pro/configuration.nix

				mnw.darwinModules.mnw
				spicetify-nix.darwinModules.spicetify
			];
		};

		nixosConfigurations."callisto" = mkHost {
			system = "x86_64-linux";

			modules = [
				./hosts/callisto/configuration.nix

				agenix.nixosModules.default
			];
		};

		nixosConfigurations."ceres" = mkHost {
			system = "aarch64-linux";

			modules = [
				./hosts/ceres/configuration.nix
				./hosts/ceres/hardware-configuration.nix

				# makes it so i have to recompile the kernel from source, reenabling once this is fixed
				#nixos-hardware.nixosModules.raspberry-pi-4
			];
		};
	};
}
