{ config, lib, pkgs, ... }: {
	config = lib.mkIf config.juno-cfg.torrenting {
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
