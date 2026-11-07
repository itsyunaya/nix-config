{
	age = {
		secrets = {
			circus-admin-password.file = ./circus.age;
			circus-admin-key.file = ./circus_key.age;
			circus-cache-key.file = ./circus_cache_key.age;
			factorio.file = ./factorio.age;
			grafana_secret = {
				file = ./grafana_secret.age;

				owner = "grafana";
				group = "grafana";
				mode = "0400";
			};
			miniflux-creds.file = ./miniflux.age;
		};
	};
}
