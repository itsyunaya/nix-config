{ fnLib, theme, pkgs, self, ... }: let
	username = "ashley";
in {
	imports = [
		(fnLib.recImport "${self}/hosts/juno/modules" { inherit username; })
		"${self}/shared/common.nix"
		"${self}/shared/spicetify"
	];

	hjem = {
		specialArgs = { inherit theme; };
		users.${username} = {
			files."wallpapers" = {
				source = "${self}/assets/wallpapers/";
				target = ".local/share/wallpapers";
			};

			imports = [ (fnLib.recImport ./hjem) ];
		};
	};

	users.users.${username} = {
		isNormalUser = true;
		description = "${username}";
		extraGroups = [ "networkmanager" "wheel" ];
		shell = pkgs.fish;

		# needs to be explicitly set for mpd
		uid = 1000;
	};

	environment = {
		sessionVariables = {
			QT_IM_MODULE = "fcitx";
			XMODIFIERS = "@im=fcitx";
			SDL_IM_MODULE = "fcitx";
			GLFW_IM_MODULE = "ibus";
			QT_QPA_PLATFORM = "wayland";
			NIXOS_OZONE_WL = "1";
			# set to nano by default for some reason
			EDITOR = "nvim";

			# meant to speed up eval speeds, 4GB rn
			GC_INITIAL_HEAP_SIZE = 1024 * 1024 * 1024 * 4;
		};
	};

	# state version should only be changed when it is really necessary,
	# as it can cause system breakage. for more info see
	# https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
	system.stateVersion = "26.11"; # Did you read the comment?
}
