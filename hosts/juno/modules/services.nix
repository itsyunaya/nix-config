{ config, lib, theme, username, ... }: {
	services = {
		displayManager.ly = {
			enable = true;
			settings = {
				session_log = ".cache/ly-session.log";
			};
		};

		dunst = {
			enable = true;
			enableX11 = false;

			settings = {
				global = {
					frame_color = "#${theme.colours.accent-pink}";
					separator_color = "frame";
					highlight = "#${theme.colours.accent-pink}";
					transparency = 20;
					offset = 20;
					font = "JetbrainsMonoNL Nerd Font";
					corner_radius = 7;
				};

				urgency_low = {
					background = "#24273a";
					foreground = "#cad3f5";
				};

				urgency_normal = {
					background = "#24273a";
					foreground = "#cad3f5";
				};

				urgency_critical = {
					background = "#24273a";
					foreground = "#cad3f5";
					frame_color = "#f5a97f";
				};
			};
		};

		gnome.gnome-keyring.enable = true;
		samba.enable = true;
		udisks2.enable = true;

		mpd = {
			enable = true;
			user = username;
			startWhenNeeded = true;

			settings = {
				music_directory = "/home/${username}/Nextcloud/";
				auto_update = true;

				audio_output = [
					{
						type = "pulse";
						name = "pulseout";
					}
				];
			};
		};

		pipewire = {
			enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			pulse.enable = true;
			jack.enable = true;
			wireplumber.enable = true;
		};

		userborn = {
			enable = true;
			# this absolutely needs to be set when the etc overlay is enabled
			# else authentication completely breaks
			passwordFilesLocation =
				if (config.system.etc.overlay.enable == true)
				then lib.mkForce "/var/lib/nixos"
				else "/etc";
		};

		xserver = {
			xkb = {
				layout = "us";
				variant = "";
			};

			videoDrivers = [ "nvidia" ];
		};
	};

	systemd.services.mpd.environment = {
		XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.${username}.uid}";
	};
}
