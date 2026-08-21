{ pkgs, inputs, ... }: {
	environment.systemPackages = let
		prism = pkgs.prismlauncher.override {
			# system glfw for running mc natively on wayland
			# only works for some versions up to 26.x
			additionalLibs = [ pkgs.glfw ];
			# "PRESS ENTER TO ENABLE THE NARRATOR !!!"
			# no shut up i dont care :sob:
			textToSpeechSupport = false;
		};

		tex-custom = pkgs.texliveSmall.withPackages (ps:
				builtins.attrValues {
					inherit
						(ps)
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
				});

		awww = inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww;
		ags-bar = inputs.ags-bar.packages.${pkgs.stdenv.hostPlatform.system}.default;
		zen = inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default;
	in
		builtins.attrValues {
			inherit
				ags-bar
				awww
				prism
				tex-custom
				zen
				;

			inherit
				(pkgs.jetbrains)
				clion
				idea
				webstorm
				;

			inherit
				(pkgs)
				alsa-utils
				anki
				apfs-fuse
				aseprite
				btop
				cifs-utils
				darkly
				eza
				ffmpeg
				ffmpegthumbnailer
				fzf
				gnome-themes-extra
				hyprshot
				keepassxc
				libnotify
				mpv
				nicotine-plus
				obsidian
				openssl
				pinentry-qt
				picard
				playerctl
				pnpm
				pwvucontrol
				qimgv
				telegram-desktop
				unzip
				wget
				whitesur-cursors
				whitesur-icon-theme
				wl-clipboard
				xdg-utils
				xlsclients
				xwl-notifier
				yams
				zathura
				;

			qt6-qtwayland = pkgs.qt6.qtwayland;
			qt5-qtwayland = pkgs.qt5.qtwayland;

			qtsvg6 = pkgs.kdePackages.qtsvg;
			qtsvg5 = pkgs.qt5.qtsvg;
		};
}
