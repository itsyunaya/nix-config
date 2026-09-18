_: {
	inputs = {
		mkWrapper.from = { parent }: parent.mkWrapper;
		nixpkgs.from = { parent }: parent.nixpkgs;
	};

	impl = { inputs }: inputs.mkWrapper {
		package = inputs.nixpkgs.pkgs.nh;
		environment = {
			NH_OS_FLAKE = "/home/ashley/Documents/sysflake/";
			NH_DARWIN_FLAKE = "/Users/ashley/.config/nix/";
		};
	};
}
