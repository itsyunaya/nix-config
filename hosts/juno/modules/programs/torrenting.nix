{ config, lib, pkgs, ... }: let
	cfg = config.programs.torrenting;
in {
	options = {
		programs.torrenting = {
			enable = lib.mkEnableOption "Torrenting";
		};
	};

	config = lib.mkIf cfg.enable {
		environment.systemPackages = builtins.attrValues {
			inherit
				(pkgs)
				qbittorrent
				;
		};

		services = {
			# needed for mullvad
			resolved.enable = true;

			mullvad-vpn = {
				enable = true;
				package = pkgs.mullvad-vpn;
			};
		};
	};
}
