{ ... }: {
	nixpkgs = {
		config.allowUnfree = true;
		flake = {
			# we don't want `<nixpkgs>`
			setNixPath = false;
			setFlakeRegistry = true;
		};
	};
}
