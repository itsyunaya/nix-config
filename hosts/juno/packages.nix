{ fnLib, pkgs, inputs, self, wrappers, ... }: {
	environment.systemPackages = let
		inherit (pkgs.stdenv.hostPlatform) system;
		inherit (self.packages.${system}) microshot;
		inherit (fnLib) mapWrappers;

		prism = pkgs.prismlauncher.override {
			# system glfw for running mc natively on wayland
			# only works for some versions up to 26.x
			additionalLibs = [ pkgs.glfw ];
			# any version can run with the newest jdk, atleast theoretically
			# tested on 1.0, 1.7.10 and 1.20
			jdks = [ pkgs.jdk25 pkgs.jdk21 ];
			textToSpeechSupport = false;
		};

		meowvim = inputs.meowvim.packages.${system}.default;
		nightingale = inputs.nightingale.packages.${system}.default;
		xwl-notifier = inputs.xwl-notifier.packages.${system}.default;
		zen = inputs.zen-browser.packages.${system}.default;
	in
		builtins.attrValues {
			inherit
				meowvim
				microshot
				nightingale
				prism
				xwl-notifier
				zen
				;

			inherit
				(pkgs)
				alsa-utils
				aseprite
				awww
				btop
				darkly
				ffmpeg
				ffmpegthumbnailer
				gnome-themes-extra
				keepassxc
				nicotine-plus
				pinentry-qt
				playerctl
				pwvucontrol
				qimgv
				tailscale-systray
				unzip
				whitesur-cursors
				whitesur-icon-theme
				wl-clipboard
				xdg-utils
				;

			qt6-qtwayland = pkgs.qt6.qtwayland;
			qt5-qtwayland = pkgs.qt5.qtwayland;

			qtsvg6 = pkgs.kdePackages.qtsvg;
			qtsvg5 = pkgs.qt5.qtsvg;
		}
		++ (mapWrappers wrappers [
			"anyrun"
			"git"
			"kitty"
			"rmpc"
			"rmpcd"
		]);
}
