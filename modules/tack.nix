{ pkgs, ... }: let
	src = pkgs.fetchFromGitHub {
		owner = "manic-systems";
		repo = "tack";
		rev = "c107b0fc252b0b33b01e6b7d6111aaaedc49613e";
		hash = "sha256-bdNCaHUF3c8hgsYw6FCI+lGcZanZIDxt2Sefu5AsERY=";
	};
in {
	programs.tack = {
		enable = true;
		package = pkgs.tack.overrideAttrs (old: {
			version = "1.0.1-unstable-2026-11-12";
			inherit src;

			cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
				inherit src;
				hash = "sha256-U8PVSnkQSmv+CZCJbwg3PltrJFXg1QKPX/7ABcAbBsA=";
			};

			nativeBuildInputs = (old.nativeBuildInputs or []) ++ [ pkgs.pkg-config ];
			buildInputs = (old.buildInputs or []) ++ [ pkgs.zstd ];
		});
	};
}
