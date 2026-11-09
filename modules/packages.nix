{ pkgs, wrappers, ... }: let
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
			;
	}
	++ (let
		mapWrappers = w: xs: map (xs': w.${xs'}.drv) xs;
	in
		mapWrappers wrappers [
			"bat"
			"eza"
			"fd"
			"less"
			"nh"
			"ripgrep"
			"yazi"
		]);
}
