{ config, username, ... }: {
	services.mpd = {
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

	# needed so mpd can use my audio output
	systemd.services.mpd.environment = {
		XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.${username}.uid}";
	};
}
