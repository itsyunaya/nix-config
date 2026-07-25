{ config, lib, pkgs, ... }: let
	cfg = config.services.minecraft;
in {
	options = {
		services.minecraft.enigmatica = {
			enable = lib.mkEnableOption "Enigmatica 9";
		};
	};

	config = lib.mkIf cfg.enigmatica.enable {
		users = {
			users.enigmatica = {
				isSystemUser = true;
				group = "enigmatica";
				home = "/srv/minecraft/enigmatica9";
			};

			groups.enigmatica = { };
		};

		networking.firewall.allowedTCPPorts = [ 2001 ];

		systemd.services.enigmatica = {
			description = "Enigmatica 9 Minecraft Server";
			wantedBy = [ "multi-user.target" ];
			wants = [ "network-online.target" ];
			after = [ "network-online.target" ];

			path = [ pkgs.jdk17_headless ];

			serviceConfig = {
				User = "enigmatica";
				WorkingDirectory = "/srv/minecraft/enigmatica9";
				ExecStart = "${pkgs.bash}/bin/bash /srv/minecraft/enigmatica9/run.sh";
				Restart = "always";
				RestartSec = 30;
			};
		};
	};
}

