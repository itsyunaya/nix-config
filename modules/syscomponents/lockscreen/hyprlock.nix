{ config, lib, ... }:

{
	config = lib.mkIf (config.itsyunaya-nix.lock-app == "hyprlock") {
		programs.hyprlock = {
			enable = true;
		};
	};
}