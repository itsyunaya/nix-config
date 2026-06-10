{ osConfig, lib, ... }: let
	shell = osConfig.itsyunaya-nix.sh.shell;
	shellBinaries = {
		zsh = "/run/current-system/sw/bin/zsh";
		nushell = "/run/current-system/sw/bin/nu";
	};
in {
	config = lib.mkMerge [
		(lib.mkIf (osConfig.itsyunaya-nix.terminal == "kitty") {
				programs.kitty = {
					enable = true;
					font.name = "JetBrainsMono Nerd Font";

					settings = {
						shell = shellBinaries.${shell};
						cursor_trail = "1";
						enable_audio_bell = "no";
						window_margin_width = "8";
						background_opacity = "0.7";

						foreground = "#cad3f5";
						cursor = "#cad3f5";

						selection_foreground = "#24273a";
						selection_background = "#cad3f5";
						url_color = "#cad3f5";

						color0 = "#494d64";
						color1 = "#ed8796";
						color2 = "#a6da95";
						color3 = "#eed49f";
						color4 = "#8aadf4";
						color5 = "#c6a0f6";
						color6 = "#7dc4e4";
						color7 = "#cad3f5";
						color8 = "#5b6078";
						color9 = "#ee99a0";
						color10 = "#a6da95";
						color11 = "#f5a97f";
						color12 = "#8aadf4";
						color13 = "#c6a0f6";
						color14 = "#7dc4e4";
						color15 = "#cad3f5";
					};
				};
			})

		(lib.mkIf (osConfig.itsyunaya-nix.terminal == "ghostty") {
				programs.ghostty = {
					enable = true;

					settings = {
						font-family = "JetBrainsMono Nerd Font";
						command = shellBinaries.${shell};

						cursor-style-blink = true;
						app-notifications = "no-clipboard-copy";

						background = "111111";
						window-padding-x = 8;
						window-padding-y = 8;
						background-opacity = 0.7;
					};
				};
			})
	];
}
