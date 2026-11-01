# i use this instead of the a-w one because that one is outdated.
# maybe i should pr an update eventually
{ promise, ... }: {
	inputs = {
		mkWrapper.from = { parent }: parent.mkWrapper;
		nixpkgs.from = { parent }: parent.nixpkgs;
		self.from = { parent }: parent.self;
	};

	inputs.mkWrapper.options = promise ({ inputs }: let
		inherit (inputs.self) sysInputs;
		inherit (inputs.nixpkgs) pkgs;
	in {
		package = import ./package.nix {
			inherit pkgs;
			inputs = sysInputs;
		};

		symlinks = {
			"$out/mango/config.toml" = ./config.toml;
		};

		flags = [ "-c" "$out/mango/config.toml" ];
	});

	result = promise ({ results }: results.mkWrapper);
}
