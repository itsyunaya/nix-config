{ pkgs, inputs, self, wrappers, ... }: {
	environment.systemPackages = let
		sys = pkgs.stdenv.hostPlatform.system;

		prism = pkgs.prismlauncher.override {
			# system glfw for running mc natively on wayland
			# only works for some versions up to 26.x
			additionalLibs = [ pkgs.glfw ];
			# any version can run with the newest jdk, atleast theoretically
			# tested on 1.0, 1.7.10 and 1.20
			jdks = [ pkgs.jdk25 pkgs.jdk21 ];
			textToSpeechSupport = false;
		};

		microshot = pkgs.callPackage "${self}/packages/microshot" {};

		git = wrappers.git { hostName = "juno"; };

		meowvim = inputs.meowvim.packages.${sys}.default;
		zen = inputs.zen-browser.packages.${sys}.default;
	in
		builtins.attrValues {
			inherit
				git
				meowvim
				microshot
				prism
				zen
				;

			#inherit
			#(pkgs.jetbrains)
			#clion
			#idea
			#webstorm
			#;

			inherit
				(pkgs)
				alsa-utils
				aseprite
				btop
				darkly
				ffmpeg
				ffmpegthumbnailer
				gnome-themes-extra
				keepassxc
				nicotine-plus
				pinentry-qt
				picard
				playerctl
				pwvucontrol
				qimgv
				unzip
				whitesur-cursors
				whitesur-icon-theme
				wl-clipboard
				xdg-utils
				xwl-notifier
				;

			qt6-qtwayland = pkgs.qt6.qtwayland;
			qt5-qtwayland = pkgs.qt5.qtwayland;

			qtsvg6 = pkgs.kdePackages.qtsvg;
			qtsvg5 = pkgs.qt5.qtsvg;
		}
		++ (let
			mapWrappers = w: xs: map (x: w.${x}.drv) xs;
		in
			mapWrappers wrappers [
				"kitty"
				"noctalia"
				"rmpc"
				"rmpcd"
			]);
}
