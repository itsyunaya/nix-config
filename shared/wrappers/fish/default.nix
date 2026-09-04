_: {
	options = {
		abbreviations.mutators = [ "/fish" "/eza" ];
		interactiveShellInit.mutators = [ "/fish" "/kitty" "/keychain" "/yazi" ];
	};

	mutations = {
		"/fish".abbreviations = _: import ./abbreviations.nix;
		"/fish".interactiveShellInit = _: builtins.readFile ./config.fish;
	};
}
