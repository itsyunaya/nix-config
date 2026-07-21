{ lib, ... }:

{
	options.juno-cfg = {
		lock-app = lib.mkOption {
			type = lib.types.enum [ "swaylock" "hyprlock" ];
			default = "swaylock";
			description = "Which lockscreen app to use (sway/hypr)";
		};

		torrenting = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Whether to enable torrenting-related services and apps";
		};
	};
}
