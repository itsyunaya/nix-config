{ pkgs, self, wrappers, ... }: let
	inherit (pkgs.stdenv.hostPlatform) system;
	inherit (self.packages.${system}) lc;

	vesktop = pkgs.vesktop.override {
		withTTS = false;
		withMiddleClickScroll = true;
	};

	mapWrappers = w: xs: map (xs': w.${xs'}.drv) xs;
in {
	environment.systemPackages = builtins.attrValues {
		inherit lc vesktop;

		inherit
			(pkgs)
			alejandra
			jq
			musicpresence
			;
	}
	++ (mapWrappers wrappers [
		"bat"
		"eza"
		"fd"
		"less"
		"nh"
		"ripgrep"
		"yazi"
	]);
}
