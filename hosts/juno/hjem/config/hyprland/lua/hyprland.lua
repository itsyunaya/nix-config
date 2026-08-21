-- hopefully managed through uwsm now
--hl.on("hyprland.start", function()
--	hl.exec_cmd("dbus-update-activation-environment --systemd DISPLAY HYPRLAND_INSTANCE_SIGNATURE WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE && systemctl --user stop hyprland-session.target && systemctl --user start hyprland-session.target")
--end)

function import(module)
	local status, _ = pcall(require, module)
	if not status then
		hl.exec_cmd("notify-send -u critical \"Hyprland\" \"Failed to load the following module: " .. module .. "\"")
		return 1
	end
	return 0
end

import("theme")
import("animations")
import("binds")
import("config")
import("events")
import("monitors")
import("rules")
