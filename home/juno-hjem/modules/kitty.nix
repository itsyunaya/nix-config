{ config, lib, pkgs, ... }: let
	cfg = config.programs.kitty;
in {
	options = {
		programs.kitty = {
			enable = lib.mkEnableOption "kitty";

			package = lib.mkPackageOption pkgs "kitty" { };
		};
	};

	config = lib.mkIf cfg.enable {
		packages = [ cfg.package ];

		xdg.config.files."kitty/kitty.conf".text = ''
			font_family JetBrainsMono Nerd Font
			background_opacity 0.7
			color0 #494d64
			color1 #ed8796
			color10 #a6da95
			color11 #f5a97f
			color12 #8aadf4
			color13 #c6a0f6
			color14 #7dc4e4
			color15 #cad3f5
			color2 #a6da95
			color3 #eed49f
			color4 #8aadf4
			color5 #c6a0f6
			color6 #7dc4e4
			color7 #cad3f5
			color8 #5b6078
			color9 #ee99a0
			cursor #cad3f5
			cursor_trail 1
			enable_audio_bell no
			foreground #cad3f5
			selection_background #cad3f5
			selection_foreground #24273a
			shell /run/current-system/sw/bin/zsh
			url_color #cad3f5
			window_margin_width 8
		'';
	};
}