{ pkgs, username, ... }: {
	users.users.${username} = {
		isNormalUser = true;
		description = "${username}";
		extraGroups = [ "networkmanager" "wheel" ];
		shell = pkgs.fish;

		# needs to be explicitly set for mpd
		uid = 1000;
	};
}
