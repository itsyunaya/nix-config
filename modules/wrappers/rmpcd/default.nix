{ promise, ... }: {
	inputs = {
		mkWrapper.from = { parent }: parent.mkWrapper;
		nixpkgs.from = { parent }: parent.nixpkgs;
		self.from = { parent }: parent.self;
	};

	inputs.mkWrapper.options = promise ({ inputs }: let
		inherit (inputs.self.sysInputs.rmpc) packages;
		inherit (inputs.nixpkgs.pkgs.stdenv.hostPlatform) system;
	in {
		package = packages.${system}.rmpcd;

		symlinks = {
			"$out/rmpcd/init.lua" = ./init.lua;
		};

		environment = {
			XDG_CONFIG_HOME = "$out";
		};
	});

	result = promise ({ results }: results.mkWrapper);
}
