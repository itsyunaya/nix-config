_: {
	inputs = {
		keychain.from = { parent }: parent.keychain;
	};

	options = {
		abbreviations.mutators = [ "/fish" "/eza" ];
		interactiveShellInit.mutators = [ "/fish" "/kitty" ];
	};

	mutations = {
		"/fish".abbreviations = _: import ./abbreviations.nix;
		"/fish".interactiveShellInit = { inputs }: let
			inherit (inputs.nixpkgs) lib;
			keychainWrapper = inputs.keychain {};
		in
			builtins.readFile ./config.fish
			+ ''
				eval (env SHELL=fish ${lib.getExe keychainWrapper})
			'';
	};
}
