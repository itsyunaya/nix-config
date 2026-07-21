{ lib, theme, ... }: {
	xdg.config.files = {
		"hypr/theme.lua" = lib.mkForce { text = theme.luaTheme; };

		"hypr/hyprland.lua" = lib.mkForce { source = ./lua/hyprland.lua; };
		"hypr/animations.lua" = lib.mkForce { source = ./lua/animations.lua; };
		"hypr/binds.lua" = lib.mkForce { source = ./lua/binds.lua; };
		"hypr/config.lua" = lib.mkForce { source = ./lua/config.lua; };
		"hypr/events.lua" = lib.mkForce { source = ./lua/events.lua; };
		"hypr/monitors.lua" = lib.mkForce { source = ./lua/monitors.lua; };
		"hypr/rules.lua" = lib.mkForce { source = ./lua/rules.lua; };
	};
}
