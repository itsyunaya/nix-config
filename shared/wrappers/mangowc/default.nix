_: {
	inputs = {
		self.from = { parent }: parent.self;
		nixpkgs.from = { parent }: parent.nixpkgs;
	};

	options = {
		configFile.default = ./config.conf;

		package.defaultFunc = { inputs }: let
			inherit (inputs.nixpkgs.pkgs.stdenv.hostPlatform) system;
		in
			inputs.self.sysInputs.mango.packages.${system}.mango;
	};
}
