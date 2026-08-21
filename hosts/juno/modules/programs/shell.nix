{ config, lib, pkgs, username, ... }: let
	extraFlags = [
		"--quiet"
		"--noask"
		# xdg compliance
		"--absolute"
		"--dir"
		"$XDG_RUNTIME_DIR/keychain"
	];

	keys = [
		"id_ed25519"
		"id_ed25519_cl"
		"ceres_key"
	];

	shellCommand = "${lib.getExe pkgs.keychain} ${lib.concatStringsSep " " extraFlags} ${lib.concatStringsSep " " keys}";
in {
	programs = {
		zsh = {
			enable = true;
			enableCompletion = true;

			shellAliases = {
				explode = "poweroff";
				nr = "nh os switch /home/ashley/sysflake -H juno";

				ls = "eza";
				ll = "eza -l";
				la = "eza -a";
				lt = "eza --tree";
				lla = "eza -la";
			};

			ohMyZsh = {
				enable = true;
				plugins = [
					"git"
					"eza"
				];
			};

			# needed to get rid of compdumps and other stupid stuff zsh creates by default
			enableGlobalCompInit = false;
			shellInit = ''
				export ZSH_COMPDUMP="''${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-$HOST-$ZSH_VERSION"
				mkdir -p "$(dirname "$ZSH_COMPDUMP")"

				zsh-newuser-install() { :; }
			'';

			histFile = "$XDG_STATE_HOME/.zsh_history";

			interactiveShellInit = lib.mkMerge [
				# kitty shell integration
				(lib.mkIf config.hjem.users.${username}.programs.kitty.enable ''
					if [[ -n "$KITTY_INSTALLATION_DIR" ]]; then
						autoload -Uz -- "$KITTY_INSTALLATION_DIR/shell-integration/zsh/kitty-integration"
						kitty-integration
						unfunction kitty-integration
					fi
				'')
				# keychain and zsh autosuggestions
				''
					eval "$(SHELL=zsh ${shellCommand})"
					source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
				''
			];

			syntaxHighlighting = {
				enable = true;

				styles = {
					# Comments
					comment = "fg=#5b6078";

					# Functions / commands
					alias = "fg=#a6da95";
					suffix-alias = "fg=#a6da95";
					global-alias = "fg=#a6da95";
					function = "fg=#a6da95";
					command = "fg=#a6da95";
					precommand = "fg=#a6da95,italic";
					autodirectory = "fg=#f5a97f,italic";
					single-hyphen-option = "fg=#f5a97f";
					double-hyphen-option = "fg=#f5a97f";
					back-quoted-argument = "fg=#c6a0f6";

					# Builtins / keywords
					builtin = "fg=#a6da95";
					reserved-word = "fg=#a6da95";
					hashed-command = "fg=#a6da95";

					# Punctuation
					commandseparator = "fg=#ed8796";
					command-substitution-delimiter = "fg=#cad3f5";
					command-substitution-delimiter-unquoted = "fg=#cad3f5";
					process-substitution-delimiter = "fg=#cad3f5";
					back-quoted-argument-delimiter = "fg=#ed8796";
					back-double-quoted-argument = "fg=#ed8796";
					back-dollar-quoted-argument = "fg=#ed8796";

					# Strings
					command-substitution-quoted = "fg=#eed49f";
					command-substitution-delimiter-quoted = "fg=#eed49f";
					single-quoted-argument = "fg=#eed49f";
					single-quoted-argument-unclosed = "fg=#ee99a0";
					double-quoted-argument = "fg=#eed49f";
					double-quoted-argument-unclosed = "fg=#ee99a0";
					rc-quote = "fg=#eed49f";

					# Variables
					dollar-quoted-argument = "fg=#cad3f5";
					dollar-quoted-argument-unclosed = "fg=#ee99a0";
					dollar-double-quoted-argument = "fg=#cad3f5";
					assign = "fg=#cad3f5";
					named-fd = "fg=#cad3f5";
					numeric-fd = "fg=#cad3f5";

					# Misc
					unknown-token = "fg=#ee99a0";
					path = "fg=#cad3f5,underline";
					path_pathseparator = "fg=#ed8796,underline";
					path_prefix = "fg=#cad3f5,underline";
					path_prefix_pathseparator = "fg=#ed8796,underline";
					globbing = "fg=#cad3f5";
					history-expansion = "fg=#c6a0f6";
					back-quoted-argument-unclosed = "fg=#ee99a0";
					redirection = "fg=#cad3f5";
					arg0 = "fg=#cad3f5";
					default = "fg=#cad3f5";
					cursor = "fg=#cad3f5";
				};
			};
		};

		starship = {
			enable = true;
			settings = {
				format = "[$username]($style)@[$hostname]($style): [$directory]($style)$line_break$character";
				add_newline = false;

				username = {
					show_always = true;
					format = "[$user]($style)";
					style_user = "bold green";
				};

				hostname = {
					ssh_only = false;
					format = "[$hostname]($style)";
					style = "bold blue";
				};

				directory = {
					truncate_to_repo = false;
					format = "[$path]($style) ";
					style = "bold cyan";
				};

				character = {
					success_symbol = "[>](bold green)";
					error_symbol = "[>](bold red)";
				};
			};
		};
	};
}
