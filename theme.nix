{ self, ... }: let
	colours = {
		bg = "191A1C";
		bg-lighter = "595959";
		accent-pink = "ffc8dd";
		accent-purple = "cdb4db";
	};
in {
	inherit colours;
	wallpaper = "${self}/assets/wallpapers/clouds.jpg";

	luaTheme = ''
    	_G.theme = {
    		pink="${colours.accent-pink}",
    		purple="${colours.accent-purple}",
    		bg="${colours.bg}",
    		bg_lighter="${colours.bg-lighter}"
    	}
	'';
}
