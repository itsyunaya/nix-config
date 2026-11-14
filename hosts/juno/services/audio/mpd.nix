{ config, username, ... }: {
	services.mpd = {
		enable = true;
		user = username;
		startWhenNeeded = true;

		settings = {
			music_directory = "/home/${username}/Nextcloud/music";
			auto_update = true;

			audio_output = [
				{
					type = "pipewire";
					name = "pipewireout";
				}
			];
		};
	};

	# needed so mpd can use my audio output
	systemd.services.mpd.environment = {
		XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.${username}.uid}";
	};
}
