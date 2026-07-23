{ config, lib, pkgs, ... }: let
	cfg = config.programs.rmpc;
in {
	options = {
		programs.rmpc = {
			enable = lib.mkEnableOption "rmpc";

			package = lib.mkPackageOption pkgs "rmpc" { };
		};
	};

	config = lib.mkIf cfg.enable {
		packages = [ cfg.package ];
		xdg.config.files = {
			"rmpc/config.ron".source = ./config.ron;
			"rmpc/themes/silly.ron".source = ./silly.ron;
		};
	};
}
