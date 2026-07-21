{
	programs.dconf.profiles.user.databases = [
		{
			settings = {
				"org/gnome/desktop/interface" = {
					color-scheme = "prefer-dark";
					gtk-theme = "Adwaita-dark";
					icon-theme = "WhiteSur-dark";
				};
			};
		}
	];

	environment.etc."gtk-3.0/settings.ini".text = ''
    		[Settings]
    		gtk-icon-theme-name=WhiteSur-dark
    		gtk-application-prefer-dark-theme=1
  '';

	environment.etc."gtk-4.0/settings.ini".text = ''
    		[Settings]
    		gtk-icon-theme-name=WhiteSur-dark
    		gtk-application-prefer-dark-theme=1
  '';

	programs.dconf.enable = true;
}
