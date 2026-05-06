{ lib, ... }:

{
	options.itsyunaya-nix.compositor = lib.mkOption {
		type = lib.types.enum [ "hyprland" "niri" ];
		default = "hyprland";
		description = "Which compositor to choose (hypr/niri)";
	};

	options.itsyunaya-nix.lock-app = lib.mkOption {
		type = lib.types.enum [ "swaylock" "hyprlock" ];
		default = "swaylock";
		description = "Which lockscreen app to use (sway/hypr)";
	};
}