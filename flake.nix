{
	description = "ashley/itsyunaya personal nixos config flake";

	# i eated the inputs :)
	# (managed with tack now, check .tack/ dir)

	outputs = { self }: let
		inputs = import ./.tack;

		alejandra-overlay = final: prev: {
			alejandra = inputs.alejandra.packages.${prev.stdenv.hostPlatform.system}.default;
		};

		mkHost = { system, modules, overlays ? [] }: let
			sysFn =
				if system == "aarch64-darwin"
				then inputs.nix-darwin.lib.darwinSystem
				else inputs.nixpkgs.lib.nixosSystem;

			pkgs = import inputs.nixpkgs { inherit system overlays; };
			wrappers = import ./shared/wrappers { inherit pkgs inputs; };
		in
			sysFn {
				inherit system;
				modules = modules ++ [ { nixpkgs.overlays = overlays ++ [ alejandra-overlay ]; } ];

				specialArgs = {
					inherit self inputs wrappers;
					fnLib = import ./lib/default.nix { inherit self pkgs; };
					# i don't need this on every device but it's easier to import it unconditionally than to make a
					# separate option for it (thank you nix lazy evaluation)
					theme = import ./theme.nix { inherit self; };
				};
			};

		systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];
		forAllSystems = f: inputs.nixpkgs.lib.genAttrs systems f;
		pkgsFor = system:
			import inputs.nixpkgs {
				inherit system;
				overlays = [ alejandra-overlay ];
			};
	in {
		nixosConfigurations = {
			"juno" = mkHost {
				system = "x86_64-linux";

				overlays = [
					inputs.musicpresence.overlays.default
					inputs.xwl-notifier.overlays.default
				];

				modules = [
					./hosts/juno/configuration.nix

					inputs.hjem.nixosModules.default
					inputs.mango.nixosModules.mango
					inputs.mnw.nixosModules.mnw
					inputs.nixos-hardware.nixosModules.msi-b550-a-pro
					inputs.qtengine.nixosModules.default
					inputs.spicetify-nix.nixosModules.spicetify
				];
			};

			"callisto" = mkHost {
				system = "x86_64-linux";

				modules = [
					./hosts/callisto/configuration.nix

					inputs.agenix.nixosModules.default
				];
			};

			"ceres" = mkHost {
				system = "aarch64-linux";

				modules = [
					./hosts/ceres/configuration.nix
					./hosts/ceres/hardware-configuration.nix

					# makes it so i have to recompile the kernel from source, reenabling once this is fixed
					#nixos-hardware.nixosModules.raspberry-pi-4
				];
			};
		};

		darwinConfigurations."ashleys-macbook-pro" = mkHost {
			system = "aarch64-darwin";

			overlays = [ inputs.musicpresence.overlays.default ];

			modules = [
				./hosts/ashleys-macbook-pro/configuration.nix

				inputs.mnw.darwinModules.mnw
				inputs.spicetify-nix.darwinModules.spicetify
			];
		};

		formatter = forAllSystems (
			system: let
				pkgs = pkgsFor system;
			in
				pkgs.writeShellApplication {
					name = "fmt";
					runtimeInputs = [ pkgs.alejandra ];
					text = ''alejandra --config-as-str='indentation = "Tabs"; space_around_brackets = true' "$@"'';
				}
		);
	};
}
