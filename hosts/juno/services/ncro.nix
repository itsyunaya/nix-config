_: {
	services.ncro = {
		enable = true;

		settings = {
			upstreams = [
				{
					url = "https://cache.nixos.org";
					public_key = "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=";
					priority = 10;
				}
				{
					url = "https://ci.itsyunaya.app/nix-cache";
					public_key = "ci.itsyunaya.app-1:fG2iQIuGodAl7chEd/EXsxr0JpQYLe/P416IGq1ot4g=";
					priority = 30;
				}
			];
		};
	};
}
