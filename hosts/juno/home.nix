{ self, pkgs, username, lib, ... }: let
	recImport = import "${self}/lib/recursiveImport.nix" { inherit lib; };
in {
	imports = [
		(recImport "${self}/home/juno")
		(recImport "${self}/home/shared")
	];

	manual.manpages.enable = false;
	programs.man.enable = false;

	gtk = {
		enable = true;
		gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
		gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
		iconTheme = {
			package = pkgs.whitesur-icon-theme;
			name = "WhiteSur-dark";
		};
	};

	home = {
		file."wallpapers" = {
			source = "${self}/assets/wallpapers/";
			target = "/home/${username}/.wallpapers";
		};

		pointerCursor = {
			enable = true;
			gtk.enable = true;
			x11.enable = true;
			package = pkgs.whitesur-cursors;
			name = "WhiteSur-cursors";
			size = 24;
		};

		sessionVariables = {
			XDG_DATA_DIRS = "$HOME/.nix-profile/share:/run/current-system/sw/share:/nix/var/nix/profiles/default/share:$XDG_DATA_DIRS";
		};

		stateVersion = "25.11";
	};
}
