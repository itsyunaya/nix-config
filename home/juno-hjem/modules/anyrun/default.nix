{ config, lib, pkgs, ... }: let
	cfg = config.programs.anyrun;

	pluginPaths = [
		"${pkgs.anyrun}/lib/libapplications.so"
		"${pkgs.anyrun}/lib/librink.so"
		"${pkgs.anyrun}/lib/libshell.so"
	];

	pluginsRon = "[" + lib.concatMapStringsSep "," (p: ''"${p}"'') pluginPaths + "]";
in {
	options = {
		programs.anyrun = {
			enable = lib.mkEnableOption "Anyrun";

			package = lib.mkPackageOption pkgs "anyrun" { };
		};
	};

	config = lib.mkIf cfg.enable {
		packages = [ cfg.package ];
		xdg.config.files = {
			"anyrun/config.ron".text = ''
				Config(
					x: Fraction(0.500000),
					y: Fraction(0.250000),
					width: Absolute(800),
					height: Absolute(1),
					margin: 0,
					hide_icons: false,
					ignore_exclusive_zones: false,
					layer: Overlay,
					hide_plugin_info: false,
					close_on_click: true,
					show_results_immediately: false,
					max_entries: None,
					plugins: ${pluginsRon},
				)
			'';

			"anyrun/style.css".source = ./style.css;
		};
	};
}