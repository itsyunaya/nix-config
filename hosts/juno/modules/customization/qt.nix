{ self, ... }: {
	qt = {
		enable = true;
		platformTheme = "kde";
	};

	# qtengine iconTheme does not work so i have to use this instead :c
	environment.etc."xdg/kdeglobals".text = builtins.readFile "${self}/assets/purple.colors"
	+ ''
		[KDE]
		widgetStyle=Darkly
		SingleClick=false

		[Icons]
		Theme=WhiteSur-dark
	'';
}
