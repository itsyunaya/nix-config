{ pkgs, ... }: let
	pkg = pkgs.nextcloud-client;
in {
	systemd.services.nextcloud-client = {
		description = "Nextcloud Client";
		after = [ "graphical-session.target" ];
		partOf = [ "graphical-session.target" ];

		serviceConfig = {
			ExecStart = "${pkg}/bin/nextcloud --background";
			ExecStop = "${pkg}/bin/nextcloud --quit";
			KillMode = "process";
			Restart = "on-failure";
			RestartSec = "5s";
			NoNewPrivileges = true;
			RestrictRealtime = true;
		};
	};
}
