{ pkgs, ... }: {
	systemd.services.scheduled-reboot = {
		description = "Nightly 4AM System Reboot";
		serviceConfig = {
			Type = "oneshot";
			ExecStart = "${pkgs.systemd}/bin/systemctl reboot";
		};
	};
}
