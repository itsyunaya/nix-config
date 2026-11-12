{ ... }: {
	# TODO: think of a better way to do common imports
	imports = [
		./debloat.nix
		./direnv.nix
		./env-vars.nix
		./nix.nix
		./nixpkgs.nix
		./packages.nix
		./tack.nix
	];
}
