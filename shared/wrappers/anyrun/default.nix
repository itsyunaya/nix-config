{ promise, ... }: {
	inputs = {
		nixpkgs.from = { parent }: parent.nixpkgs;
	};

	options = {
		configFiles.default."config.ron" = ./config.ron;

		cssFile.default = ./style.css;

		pluginPaths.default = promise ({ inputs }: let
			inherit (inputs.nixpkgs.pkgs) anyrun;
		in [
			"${anyrun}/lib/libapplications.so"
			"${anyrun}/lib/librink.so"
			"${anyrun}/lib/libshell.so"
		]);
	};
}
