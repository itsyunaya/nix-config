_: {
	options = {
		abbreviations.mutators = [ "/fish" "/eza" ];
		interactiveShellInit.mutators = [ "/fish" "/kitty" ];
	};

	mutations = {
		"/fish".abbreviations = _: import ./abbreviations.nix;
		"/fish".interactiveShellInit = _: builtins.readFile ./config.fish;
	};
}
