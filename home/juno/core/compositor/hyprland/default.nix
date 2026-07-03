{
	osConfig,
	lib,
	inputs,
	pkgs,
	theme,
	...
}: {
	config =
		lib.mkIf (osConfig.juno-cfg.compositor == "hyprland") {
			wayland.windowManager.hyprland = {
				enable = true;
				package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

				configType = "lua";
				extraConfig = builtins.readFile ./lua/hyprland.lua;
			};

			xdg.configFile = {
				"hypr/theme.lua" = lib.mkForce {
					text = theme.luaTheme;
				};

				"hypr/animations.lua" = lib.mkForce { source = ./lua/animations.lua; };
				"hypr/binds.lua" = lib.mkForce { source = ./lua/binds.lua; };
				"hypr/config.lua" = lib.mkForce { source = ./lua/config.lua; };
				"hypr/events.lua" = lib.mkForce { source = ./lua/events.lua; };
				"hypr/monitors.lua" = lib.mkForce { source = ./lua/monitors.lua; };
				"hypr/rules.lua" = lib.mkForce { source = ./lua/rules.lua; };
			};
		};
}
