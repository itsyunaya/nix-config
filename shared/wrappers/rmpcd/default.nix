_: {
	inputs = {
		mkWrapper.from = { parent }: parent.mkWrapper;
		nixpkgs.from = { parent }: parent.nixpkgs;
		self.from = { parent }: parent.self;
	};

	impl = { inputs }: let
		inherit (inputs.self.sysInputs.rmpc) packages;
		inherit (inputs.nixpkgs.pkgs.stdenv.hostPlatform) system;
	in
		inputs.mkWrapper {
			package = packages.${system}.rmpcd;

			symlinks = {
				"$out/rmpcd/init.lua" = ./init.lua;
			};

			environment = {
				XDG_CONFIG_HOME = "$out";
			};
		};
}
