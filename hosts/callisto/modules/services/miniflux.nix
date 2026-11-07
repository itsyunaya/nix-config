{ config, ... }: {
	services.miniflux = {
		enable = true;
		adminCredentialsFile = config.age.secrets.miniflux-creds.path;
		config = {
			LISTEN_ADDR = "0.0.0.0:9020";
		};
	};
}
