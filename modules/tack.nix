{ pkgs, ... }: let
	src = pkgs.fetchFromGitHub {
		owner = "manic-systems";
		repo = "tack";
		rev = "1424edc27b6e6f6d4f216410e0a2cc1419d96cb7";
		hash = "sha256-z7m16oDAtHsgbBX6gadOpa6pGPXNEahjwyzPC0pbLvM=";
	};
in {
	programs.tack = {
		enable = true;
		package = pkgs.tack.overrideAttrs (old: {
			version = "1.0.1-unstable-2026-11-20";
			inherit src;

			cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
				inherit src;
				hash = "sha256-LvS59RrgR4/VdO461KlY3+1PgIfNuB7akmqPVg029zs=";
			};

			nativeBuildInputs = (old.nativeBuildInputs or []) ++ [ pkgs.pkg-config ];
			buildInputs = (old.buildInputs or []) ++ [ pkgs.zstd ];
		});
	};
}
