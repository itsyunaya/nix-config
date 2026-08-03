{ pkgs, ... }: let
	# tests explode on macos for some reason
	tack = pkgs.tack.overrideAttrs (old: {
			doCheck =
				if pkgs.stdenv.isDarwin
				then false
				else true;
		});

	vesktop = pkgs.vesktop.override {
		withTTS = false;
		withMiddleClickScroll = true;
	};
in {
	environment.systemPackages = builtins.attrValues {
		inherit
			tack
			vesktop
			;

		inherit
			(pkgs)
			alejandra
			musicpresence
			nh
			nil
			nodejs-slim
			pnpm
			ripgrep
			statix
			;
	};
}
