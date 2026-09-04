{ pkgs, theme, ... }: {
	packages = [ pkgs.hyprlock ];

	xdg.config.files."hypr/hyprlock.conf".text = ''
		background {
			monitor=
			blur_passes=1
			blur_size=5
			brightness=0.800000
			contrast=1.300000
			noise=0.011700
			path=${theme.wallpaper}
			vibrancy=0.210000
			vibrancy_darkness=0.000000
		}

		input-field {
			monitor=
			size=250, 50
			dots_center=true
			dots_size=0.200000
			dots_spacing=0.350000
			font_color=rgba(ffffffff)
			halign=center
			hide_input=false
			inner_color=rgba(${theme.colours.bg}ff)
			outer_color=rgba(${theme.colours.accent-pink}ff)
			outline_thickness=3
			placeholder_text=<i>Password...</i>
			position=0, 60
			valign=bottom
		}

		label {
			monitor=
			color=rgba(ffffffff)
			font_family=IBM Plex Sans Medium 10
			font_size=128
			halign=center
			position=0, 160
			text=cmd[update:1000] echo "<b><big> $(date +"%H") </big></b>"
			valign=center
		}

		         label {
			monitor=
			color=rgba(ffffffff)
			font_family=IBM Plex Sans Medium 10
			font_size=128
			halign=center
			position=0, 0
			text=cmd[update:1000] echo "<b><big> $(date +"%M") </big></b>"
			valign=center
		}

		label {
			monitor=
			color=rgba(ffffffff)
			font_family=IBM Plex Sans Medium 10
			font_size=16
			halign=center
			position=0, -100
			text=cmd[update:1000] echo "<b><big> $(date +"%d %b") </big></b>"
			valign=center
		}

		label {
			monitor=
			color=rgba(ffffffff)
			font_family=IBM Plex Sans Medium 10
			font_size=16
			halign=center
			position=0, -120
			text=cmd[update:1000] echo "<b><big> $(date +"%A") </big></b>"
			valign=center
		}
	'';
}
