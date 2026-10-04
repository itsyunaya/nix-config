{ promise, ... }: {
	options = {
		abbreviations.mutators = [ "/fish" "/eza" ];
		interactiveShellInit.mutators = [ "/fish" "/kitty" "/keychain" "/yazi" ];
	};

	mutations = {
		"/fish".abbreviations = promise (_: import ./abbreviations.nix);
		"/fish".interactiveShellInit = promise (_: builtins.readFile ./config.fish);
	};
}
