{ fnLib, pkgs, wrappers, ... }: let
	username = "ashley";

	pixel-berry-theme = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
		mktplcRef = {
			name = "pixel-berry";
			publisher = "germainelry";
			version = "0.1.3";
			sha256 = "sha256-Jrs8BPY/d6F/lbyc9YcVlYON7ZirBApgzG3Tws9jaME=";
		};
	};

	# this sucks a bit since the hjem module for it is *right there*, but i can't properly add it to my packages
	# because linking to users.packages (what hjem does) doesn't add it to Applications/
	vscode = pkgs.vscode-with-extensions.override {
		vscode = pkgs.vscodium;
		vscodeExtensions = with pkgs.vscode-extensions; [
			jnoortheen.nix-ide
			pixel-berry-theme
			haskell.haskell
			justusadam.language-haskell
		];
	};
in {
	users.users.${username} = {
		home = /Users/${username};
	};

	imports = fnLib.fromShared [
		"common"
		#"git"
		"mnw"
		"spicetify"
	];

	documentation.enable = false;

	environment = {
		systemPackages = builtins.attrValues {
			inherit
				vscode
				;

			inherit
				(pkgs)
				gnupg
				localsend
				pinentry_mac
				skimpdf
				;
		} ++ [
			(wrappers.git { hostName = "macbook"; })
		];

		# i might need this on linux too, unsure
		# todo: check if .local/bin is on PATH on linux
		variables."PATH" = "$PATH:$HOME/.local/bin";

		shellAliases.rb = "nh darwin switch /Users/ashley/.config/nix";
	};

	programs.zsh = {
		enable = true;

		enableAutosuggestions = true;
		enableSyntaxHighlighting = true;

		# this module is stupid and autoloads a theme so it needs to be manually disabled
		promptInit = "";

		# this needs to be off since we are initializing it manually with the correct dir for the compdumps
		enableCompletion = false;

		histFile = "$XDG_STATE_HOME/.zsh_history";

        interactiveShellInit = ''
        	autoload -Uz compinit
            compinit -d "$XDG_CACHE_HOME/zcompdump-$ZSH_VERSION"

			eval "$(/opt/homebrew/bin/brew shellenv)"
			PROMPT="%{%F{#c6a0f6}%}[%{%F{#fefefe}%}%n%{%F{#c6a0f6}%}@%{%F{#fefefe}%}%m%{%F{#c6a0f6}%}] (%{%F{#fefefe}%}%1~%{%F{#c6a0f6}%}) %{%f%}$ "
		'';
	};

	system.stateVersion = 7;
}
