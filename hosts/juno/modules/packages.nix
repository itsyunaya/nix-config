{ pkgs, inputs, self, wrappers, ... }: {
	environment.systemPackages = let
		sys = pkgs.stdenv.hostPlatform.system;

		prism = pkgs.prismlauncher.override {
			# system glfw for running mc natively on wayland
			# only works for some versions up to 26.x
			additionalLibs = [ pkgs.glfw ];
			textToSpeechSupport = false;
		};

		microshot = pkgs.callPackage "${self}/packages/microshot" {};

		awww = inputs.awww.packages.${sys}.awww;
		ags-bar = inputs.ags-bar.packages.${sys}.default;
		meowvim = inputs.meowvim.packages.${sys}.default;
		zen = inputs.zen-browser.packages.${sys}.default;
	in
		builtins.attrValues {
			inherit
				ags-bar
				awww
				meowvim
				microshot
				prism
				zen
				;

			inherit
				(pkgs.jetbrains)
				#clion
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
				ffmpeg
				ffmpegthumbnailer
				fzf
				gale
				gnome-themes-extra
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
		} ++ [
			wrappers.anyrun.drv
			(wrappers.git { hostName = "juno"; })
			wrappers.kitty.drv
			wrappers.rmpc.drv
		];
}
