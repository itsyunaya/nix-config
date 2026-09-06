{ pkgs, self, ... }: let
	username = "ashley";
in {
	users = {
		knownUsers = [ username ];
		users.${username} = {
			home = /Users/${username};
			shell = pkgs.fish;
			uid = 501;
		};
	};

	imports = [
		./programs.nix
		"${self}/shared/common.nix"
		"${self}/shared/spicetify"
	];

	documentation.enable = false;

	environment = {
		variables = {
			"PATH" = "$PATH:$HOME/.local/bin";
			"EDITOR" = "nvim";
		};

		shellAliases.rb = "nh darwin switch /Users/ashley/.config/nix";
	};

	system.stateVersion = 7;
}
