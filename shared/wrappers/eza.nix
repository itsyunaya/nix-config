_: {
	options = {
		# abbreviates nix store hashes, *very* useful for readability
		flags.defaultFunc = _: [ "--short-nix" ];
	};

	mutations."/fish".abbreviations = _: {
		ls = "eza";
		ll = "eza -l";
		la = "eza -a";
		lt = "eza --tree";
		lla = "eza -la";
	};
}
