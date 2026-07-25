{ pkgs, ... }: let
	vesktop = pkgs.vesktop.override {
		withTTS = false;
		withMiddleClickScroll = true;
	};
in {
	environment.systemPackages = builtins.attrValues {
		inherit
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
