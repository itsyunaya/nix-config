{
	services.nextcloud = {
		enable = true;
		hostName = "nxtcld.local";
		datadir = "/srv/nextcloud/";
		https = true;

		database.createLocally = true;

		config = {
			dbtype = "pgsql";
		};

		settings.trusted_domains = [
			"nxtcld.local:81" # not actually used
			"192.168.178.10:81" # local network
			"100.115.15.84:81" # tailscale
		];
	};
}
