{ config, lib, ... }: {
	services = {
		displayManager.ly = {
			enable = true;
			settings = {
				session_log = ".cache/ly-session.log";
			};
		};

		gnome.gnome-keyring.enable = true;
		samba.enable = true;
		udisks2.enable = true;

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
}
