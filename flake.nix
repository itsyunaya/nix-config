{
	description = "ashley/itsyunaya personal nixos config flake";

	# i eated the inputs :)
	# (managed with tack now, check .tack/ dir)

	outputs = { self }: let
		alejandra-overlay = final: prev: {
			alejandra = inputs.alejandra.packages.${prev.stdenv.hostPlatform.system}.default;
		};

		inputs = import ./.tack;

		mkHost = { system, modules, overlays ? [], workstation ? false }: let
			sysFn =
				if system == "aarch64-darwin"
				then inputs.nix-darwin.lib.darwinSystem
				else inputs.nixpkgs.lib.nixosSystem;

			pkgs = import inputs.nixpkgs { inherit system overlays; };
			wrappers = import ./shared/wrappers { inherit pkgs inputs; };
		in
			sysFn {
				inherit system;
				modules = modules ++ [ { nixpkgs.overlays = overlays; } ];

				specialArgs = {
					inherit self inputs wrappers;
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
				# nixpkgs gale can't launch steam because of some issue, and the associated pr hasn't been merged yet
				(_: _: {
					gale = inputs.nixpkgs.legacyPackages."x86_64-linux".callPackage ./packages/gale.nix { };
				})

				alejandra-overlay
				inputs.musicpresence.overlays.default
				inputs.xwl-notifier.overlays.default
			];

			modules = [
				./hosts/juno/configuration.nix

				inputs.hjem.nixosModules.default
				inputs.mnw.nixosModules.mnw
				inputs.nixos-hardware.nixosModules.msi-b550-a-pro
				inputs.qtengine.nixosModules.default
				inputs.spicetify-nix.nixosModules.spicetify
			];
		};

		darwinConfigurations."ashleys-macbook-pro" = mkHost {
			system = "aarch64-darwin";
			workstation = true;

			overlays = [
				alejandra-overlay
				inputs.musicpresence.overlays.default
			];

			modules = [
				./hosts/ashleys-macbook-pro/configuration.nix

				inputs.mnw.darwinModules.mnw
				inputs.spicetify-nix.darwinModules.spicetify
			];
		};

		nixosConfigurations."callisto" = mkHost {
			system = "x86_64-linux";

			modules = [
				./hosts/callisto/configuration.nix

				inputs.agenix.nixosModules.default
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
