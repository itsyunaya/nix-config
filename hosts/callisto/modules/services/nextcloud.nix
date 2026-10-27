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

		settings.trusted_domains = [ "nxtcld.local:81" "192.168.178.10:81" ];
	};
}
