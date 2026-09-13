{ pkgs, ... }: {
	systemd.services.scheduled-reboot = {
		description = "4AM System Reboot";
		serviceConfig = {
			Type = "oneshot";
			ExecStart = "${pkgs.systemd}/bin/systemctl reboot";
		};
	};
}
