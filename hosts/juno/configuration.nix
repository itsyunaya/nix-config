{ fnLib, theme, pkgs, self, ... }: let
	username = "ashley";
in {
	nix.settings.experimental-features = [
		"nix-command"
		"flakes"
	];

	imports =
		[
			(fnLib.recImport "${self}/hosts/juno/modules" { inherit username; })
		]
		++ (fnLib.fromShared [
				# see shared/README.md
				"common-pkgs"
				"git"
				"mnw"
				"spicetify"
			]);

	hjem = {
		specialArgs = { inherit theme; };
		extraModules = [ (fnLib.recImport ./hjem/modules) ];
		users.${username} = {
			files."wallpapers" = {
				source = "${self}/assets/wallpapers/";
				target = ".wallpapers";
			};

			xdg.config.files."mpDris2/mpDris2.conf".text = ''
				[Connection]
				music_dir = /home/${username}/Nextcloud

				[Bling]
                notify = False
			'';

			imports = [ (fnLib.recImport ./hjem/config) ];
		};
	};

	users.users.${username} = {
		isNormalUser = true;
		description = "${username}";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = [];
		shell = pkgs.zsh;

		# needs to be explicitly set for mpd
		uid = 1000;
	};

	environment.sessionVariables = {
		QT_IM_MODULE = "fcitx";
		XMODIFIERS = "@im=fcitx";
		SDL_IM_MODULE = "fcitx";
		GLFW_IM_MODULE = "ibus";
		QT_QPA_PLATFORM = "wayland";
		NIXOS_OZONE_WL = "1";
	};

	# state version should only be changed when it is really necessary,
	# as it can cause system breakage. for more info see
	# https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
	system.stateVersion = "25.11"; # Did you read the comment?
}
