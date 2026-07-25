{ fnLib, pkgs, ... }: let
	username = "ashley";
in {
	nix.settings.experimental-features = [
		"nix-command"
		"flakes"
	];

	users.users.${username} = {
		home = /Users/${username};
	};

	imports = fnLib.fromShared [
		"common-pkgs"
		"git"
		"mnw"
		"spicetify"
	];

	nixpkgs.config.allowUnfree = true;

	environment.systemPackages = builtins.attrValues {
		inherit
			(pkgs)
			gnupg
			localsend
			pinentry_mac
			skimpdf
			;
	};

	environment.shellAliases = {
		rb = "nh darwin switch /Users/ashley/.config/nix";
	};

	programs.zsh = {
		enable = true;

		enableAutosuggestions = true;
		enableSyntaxHighlighting = true;

		# this module is stupid and autoloads a theme so it needs to be manually disabled
		promptInit = "";

        interactiveShellInit = ''
			eval "$(/opt/homebrew/bin/brew shellenv)"
			PROMPT="%{%F{#c6a0f6}%}[%{%F{#fefefe}%}%n%{%F{#c6a0f6}%}@%{%F{#fefefe}%}%m%{%F{#c6a0f6}%}] (%{%F{#fefefe}%}%1~%{%F{#c6a0f6}%}) %{%f%}$ "
		'';
	};
	
	system.stateVersion = 7;
}
