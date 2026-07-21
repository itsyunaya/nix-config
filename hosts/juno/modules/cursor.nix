{
	environment.sessionVariables = {
		XCURSOR_THEME = "WhiteSur-cursors";
		XCURSOR_SIZE = "24";
	};

	environment.etc."X11/icons/default/index.theme".text = ''
		[Icon Theme]
		Name=Default
		Comment=Default Cursor Theme
		Inherits=WhiteSur-cursors
	'';

	environment.etc."Xresources".text = ''
		Xcursor.theme: WhiteSur-cursors
		Xcursor.size: 24
	'';

	environment.etc."gtk-3.0/settings.ini".text = ''
		[Settings]
		gtk-cursor-theme-name=WhiteSur-cursors
		gtk-cursor-theme-size=24
	'';

	environment.etc."gtk-4.0/settings.ini".text = ''
		[Settings]
		gtk-cursor-theme-name=WhiteSur-cursors
		gtk-cursor-theme-size=24
	'';
}
