{ inputs, self, pkgs, username, ... }: let
	tree = inputs.import-tree;
in {
	# imports managed through import-tree
	imports = [
		(tree "${self}/modules/juno")
		(tree "${self}/modules/shared")
	];

	home.packages = with pkgs; [
		(pkgs.texlive.combine {
				inherit
					(pkgs.texlive)
					scheme-medium
					biber
					biblatex
					biblatex-bath
					circuitikz
					csquotes
					lastpage
					mdframed
					needspace
					pgfplots
					svg
					transparent
					wrapfig
					zref
					;
			})

		alsa-utils
		anki
		aseprite
		btop
		(discord.override {
				withVencord = true;
			})
		fd
		fzf
		haskell-language-server
		hyprpicker
		hyprshot
		jetbrains.clion
		jetbrains.idea
		jetbrains.webstorm
		keepassxc
		mpdas
		(pkgs.callPackage "${self}/packages/musicpresence.nix" {})
		nicotine-plus
		pavucontrol
		picard
		(prismlauncher.override {
				# lets the game run on native wayland instead of the israeli display server
				additionalLibs = [ glfw ];
			})
		qbittorrent
		rmpc
		ripgrep
		steam
		telegram-desktop
		vesktop
		xlsclients
		yams
		xwl-notifier
		inputs.zen-browser.packages."${stdenv.hostPlatform.system}".default
	];

	services.mpd = {
		enable = true;
		musicDirectory = "/home/${username}/Nextcloud/music";

		extraConfig = ''
      		auto_update "yes"

      		audio_output {
      			type "pulse"
      			name "pulseout"
      		}
    	'';
	};

	services.nextcloud-client = {
		enable = true;
		startInBackground = true;
	};

	gtk = {
		enable = true;
		gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
		gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
		iconTheme = {
			package = pkgs.whitesur-icon-theme;
			name = "WhiteSur-dark";
		};
	};

	qt = {
		enable = true;
		platformTheme.name = "gtk";
		style.name = "adwaita-dark";
	};

	dconf.settings = {
		"org/gnome/desktop/interface".color-scheme = "prefer-dark";
	};

	xdg.mimeApps = {
		enable = true;
		defaultApplications = {
			"x-scheme-handler/http" = "zen-beta.desktop";
			"x-scheme-handler/https" = "zen-beta.desktop";
			"x-scheme-handler/chrome" = "zen-beta.desktop";
			"text/html" = "zen-beta.desktop";
			"x-scheme-handler/discord" = "vesktop.desktop";
			"x-scheme-handler/tg" = "org.telegram.desktop.desktop";
			"inode/directory" = "thunar.desktop";

			"image/png" = "qimgv.desktop";
			"image/jpeg" = "qimgv.desktop";
			"image/gif" = "qimgv.desktop";
			"image/webp" = "qimgv.desktop";
			"image/bmp" = "qimgv.desktop";
			"image/svg+xml" = "qimgv.desktop";
		};
	};

	home = {
		pointerCursor = {
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
