{
	systemd.timers.scheduled-reboot = {
		description = "Nightly 4AM System Reboot";

		wantedBy = [ "timers.target" ];
		timerConfig.OnCalendar = "*-*-* 4:00:00";
	};
}
