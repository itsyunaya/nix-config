{ pkgs, self, ... }: let
	username = "ashley";
in {
	users.users.${username} = {
		home = /Users/${username};
	};

	imports = [
		"${self}/shared/git.nix"
		"${self}/shared/mnw"
		"${self}/shared/spicetify.nix"
	];

	nixpkgs.config.allowUnfree = true;

	environment.systemPackages = builtins.attrValues {
		inherit
			(pkgs)
			alejandra
			gnupg
			localsend
			musicpresence
			neovim
			nil
			nodejs-slim
			pinentry_mac
			pnpm
			ripgrep
			statix
			skimpdf
			vesktop
			;
	};

	environment.shellAliases = {
		rb = "sudo darwin-rebuild switch --flake ~/.config/nix";
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
