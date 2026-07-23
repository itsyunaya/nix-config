{ config, lib, pkgs, ... }: let
	cfg = config.services.nextcloud-client;
in {
	options = {
		services.nextcloud-client = {
			enable = lib.mkEnableOption "Nextcloud Client";

			package = lib.mkPackageOption pkgs "nextcloud-client" { };
		};
	};

	config = lib.mkIf cfg.enable {
		systemd.services.nextcloud-client = {
			description = "Nextcloud Client";
			after = [ "graphical-session.target" ];
			partOf = [ "graphical-session.target" ];

			serviceConfig = {
				ExecStart = "${cfg.package}/bin/nextcloud --background";
				ExecStop = "${cfg.package}/bin/nextcloud --quit";
				KillMode = "process";
				Restart = "on-failure";
				RestartSec = "5s";
				NoNewPrivileges = true;
				RestrictRealtime = true;
			};
		};
	};
}
