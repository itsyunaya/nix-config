{ config, pkgs, ... }: {
	# TODO: open issue about this on circus repo
	systemd.services.circus-server.path = [ pkgs.git ];

	services.circus = {
		enable = true;

		server.enable = true;
		evaluator.enable = true;
		queueRunner.enable = true;

		settings = {
			server = {
				host = "127.0.0.1";
				port = 9200;

				force_secure_cookies = true;
				rate_limit_rps = 100;
				rate_limit_burst = 20;
			};

			signing = {
				enabled = true;
				key_file = config.age.secrets.circus-cache-key.path;
				public_key = "ci.itsyunaya.app-1:fG2iQIuGodAl7chEd/EXsxr0JpQYLe/P416IGq1ot4g=";
			};

			evaluator.poll_interval = 300;
			evaluator.restrict_eval = true;
			queue_runner.workers = 8;
			queue_runner.build_timeout = 7200;

			gc.enabled = true;
			gc.max_age_days = 90;

			cache = {
				enabled = true;
				cache_url = "https://ci.itsyunaya.app/nix-cache";
				upstreams = [
					{
						url = "https://cache.nixos.org";
						public_key = "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=";
					}
				];
			};

			logs.log_dir = "/var/lib/circus/logs";
			logs.compress = true;

			declarative = {
				users = [
					{
						username = "admin";
						email = "hey@itsyunaya.app";
						password_file = config.age.secrets.circus-admin-password.path;
						role = "admin";
					}
				];

				api_keys = [
					{
						name = "admin-key";
						key_file = config.age.secrets.circus-admin-key.path;
						role = "admin";
					}
				];
			};
		};
	};
}
