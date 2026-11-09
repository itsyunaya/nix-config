{ ... }: {
	nix = {
		channel.enable = false;
		optimise = {
			automatic = true;
		};
		settings = {
			# for more info see
			# https://nix.dev/manual/nix/2.35/language/import-from-derivation
			allow-import-from-derivation = false;

			experimental-features = [
				"nix-command"
				"flakes"
			];

			substituters = [
				"https://cache.nixos.org/"
				"https://ci.itsyunaya.app/nix-cache"
			];

			trusted-public-keys = [
				"cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
				"ci.itsyunaya.app-1:fG2iQIuGodAl7chEd/EXsxr0JpQYLe/P416IGq1ot4g="
			];

			use-xdg-base-directories = true;

			# disables git tree dirty warning because it's kinda useless for me
			warn-dirty = false;
		};
	};
}
