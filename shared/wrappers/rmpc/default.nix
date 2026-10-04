{ promise, ... }: {
	inputs = {
		self.from = { parent }: parent.self;
	};

	options = {
		configFile.default = ./config.ron;
		themes.default = {
			"silly" = ./silly.ron;
			"theme" = ./theme.ron;
		};

		package.default = promise (
			{ inputs }: let
				inherit (inputs.self.sysInputs.rmpc) packages;
				inherit (inputs.nixpkgs.pkgs.stdenv.hostPlatform) system;
			in
				packages.${system}.default
		);
	};
}
