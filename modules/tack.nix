{ pkgs, ... }: let
	src = pkgs.fetchFromGitHub {
		owner = "manic-systems";
		repo = "tack";
		rev = "ea48abbf5ceb99d4e150b545767a2159f3e07979";
		hash = "sha256-rpcW35sv5exqvhZ0uuyY/14KXaS9hndXJ5qb4DiLFIo=";
	};
in {
	programs.tack = {
		enable = true;
		package = pkgs.tack.overrideAttrs {
			version = "1.0.1-unstable-2026-11-9";
			inherit src;

			cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
				inherit src;
				hash = "sha256-edYigZ2aQYbxmHuuIiQo9lMTsu3YFgaRySgVbbSVY0I=";
			};
		};
	};
}
