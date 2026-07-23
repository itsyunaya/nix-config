{ inputs, lib, pkgs, self, ... }: let
	username = "ashley";
	recImport = import "${self}/lib/recursiveImport.nix" { inherit lib; };
in {
	users.users.${username} = {
		home = /Users/${username};
	};

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

        interactiveShellInit = ''
			eval "$(/opt/homebrew/bin/brew shellenv)"
			PROMPT="%{%F{#c6a0f6}%}[%{%F{#fefefe}%}%n%{%F{#c6a0f6}%}@%{%F{#fefefe}%}%m%{%F{#c6a0f6}%}] (%{%F{#fefefe}%}%1~%{%F{#c6a0f6}%}) %{%f%}$ "
		'';
	};
	
	system.stateVersion = 7;
}
