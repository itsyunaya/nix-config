{ pkgs, self, ... }: let
	username = "ashley";
in {
	users = {
		knownUsers = [ username ];
		users.${username} = {
			home = "/Users/${username}";
			shell = pkgs.fish;
			uid = 501;
		};
	};

	imports = [
		./programs.nix
		./tack.nix
		"${self}/modules/"
		"${self}/modules/spicetify"
	];

	documentation.enable = false;

	environment = {
		variables = {
			"PATH" = "$PATH:$HOME/.local/bin";
			"EDITOR" = "nvim";
		};
	};

	system.stateVersion = 7;
}
