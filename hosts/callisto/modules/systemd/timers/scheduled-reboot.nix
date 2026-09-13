{
	systemd.timers.scheduled-reboot = {
		description = "4AM System Reboot";

		wantedBy = [ "timers.target" ];
		timerConfig.OnCalendar = "*-*-1/3 4:00:00";
	};
}
