{
	services.tailscale = {
		enable = true;
		openFirewall = true;

		extraDaemonFlags = [ "--no-logs-no-support" ];
	};
}
