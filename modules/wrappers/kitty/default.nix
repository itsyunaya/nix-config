_: {
	options = {
		configFile.default = ./kitty.conf;

		# this needs to be specified, otherwise an eval error occurs. themeFile
		# is also used instead of theme so kitty-themes doesn't get pulled
		themeFile.default = "";
	};
}
