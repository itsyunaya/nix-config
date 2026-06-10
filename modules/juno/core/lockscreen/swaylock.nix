{ osConfig, lib, theme, ... }:

{
	config = lib.mkIf (osConfig.itsyunaya-nix.lock-app == "swaylock") {
		programs.swaylock = {
    		enable = true;
    	};

        xdg.configFile."swaylock/config".text =
            ''
                image=${theme.wallpaper}
            '';
	};
}
