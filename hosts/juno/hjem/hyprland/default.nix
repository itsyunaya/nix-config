{ lib, theme, ... }: let
	enabled = false;
in {
	xdg.config.files = {
		"hypr/theme.lua" = lib.mkForce { text = theme.luaTheme; enable = enabled; };

		"hypr/hyprland.lua" = lib.mkForce { source = ./lua/hyprland.lua; enable = enabled; };
		"hypr/animations.lua" = lib.mkForce { source = ./lua/animations.lua; enable = enabled; };
		"hypr/binds.lua" = lib.mkForce { source = ./lua/binds.lua; enable = enabled; };
		"hypr/config.lua" = lib.mkForce { source = ./lua/config.lua; enable = enabled; };
		"hypr/events.lua" = lib.mkForce { source = ./lua/events.lua; enable = enabled; };
		"hypr/monitors.lua" = lib.mkForce { source = ./lua/monitors.lua; enable = enabled; };
		"hypr/rules.lua" = lib.mkForce { source = ./lua/rules.lua; enable = enabled; };
	};
}
