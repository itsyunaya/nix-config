{ config, pkgs, username, ... }: {
	services = {
		mpd = {
			enable = true;
			user = username;
			startWhenNeeded = true;

			settings = {
				music_directory = "/home/${username}/Nextcloud/";
				auto_update = true;

				audio_output = [
					{
						type = "pipewire";
						name = "pipewireout";
					}
				];
			};
		};

		pipewire = {
			enable = true;
			alsa.enable = true;
			# disabling these because i don't think i need them, if something audio related breaks reenabling them
			# might be a good starting point to debug the issue
			#pulse.enable = true;
			#jack.enable = true;
			# *should* be on by default
			#wireplumber.enable = true;
		};
	};

	# needed so mpd can use my audio output
	systemd.services.mpd.environment = {
		XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.${username}.uid}";
	};

	# replacement for mpd-mpris since it doesn't handle play state changes well
	systemd.user.services.mpdris2 = {
		description = "MPRIS 2 support for MPD";
		after = [ "mpd.service" ];
		wantedBy = [ "default.target" ];
		serviceConfig = {
			Type = "simple";
			Restart = "on-failure";
			RestartSec = "5s";
			ExecStart = "${pkgs.mpdris2}/bin/mpDris2";
			BusName = "org.mpris.MediaPlayer2.mpd";
		};
	};
}
