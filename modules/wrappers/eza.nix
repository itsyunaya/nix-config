_: {
	options = {
		# abbreviates nix store hashes, *very* useful for readability
		flags.default = [ "--short-nix" ];
	};

	mutations."/fish".abbreviations = {
		ls = "eza";
		ll = "eza -l";
		la = "eza -a";
		lt = "eza --tree";
		lla = "eza -la";
	};
}
