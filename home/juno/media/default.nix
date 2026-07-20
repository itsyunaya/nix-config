{ username, ... }: {
	services.mpd = {
		enable = true;
		musicDirectory = "/home/${username}/Nextcloud/";

		extraConfig = ''
			auto_update "yes"

			audio_output {
				type "pulse"
				name "pulseout"
			}
		'';
	};
}
