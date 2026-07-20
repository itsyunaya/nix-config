{ config, lib, pkgs, ... }: let
	cfg = config.programs.vscode;

	vscodePackage = pkgs.vscode-with-extensions.override {
		vscodeExtensions = cfg.extensions;
	};
in {
	options = {
		programs.vscode = {
			enable = lib.mkEnableOption "Visual Studio Code";

			extensions = lib.mkOption {
				type = lib.types.listOf lib.types.package;
				default = [];
			};

			settings = lib.mkOption {
				type = (pkgs.formats.json { }).type;
				default = {};
			};
		};
	};

	config = lib.mkIf cfg.enable {
		packages = [ vscodePackage ];

		xdg.config.files."Code/User/settings.json" = {
			generator = (pkgs.formats.json { }).generate "settings.json";
			value = cfg.settings;
		};
	};
}
