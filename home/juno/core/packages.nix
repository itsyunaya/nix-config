{ inputs, pkgs, ... }: let
	discord = pkgs.discord.override {
		withVencord = true;
	};

	prism = pkgs.prismlauncher.override {
		# system glfw for running mc natively on wayland
		# only works for some versions up to 26.x
		additionalLibs = [ pkgs.glfw ];
		# "PRESS ENTER TO ENABLE THE NARRATOR !!!"
		# no shut up i dont care :sob:
		textToSpeechSupport = false;
	};

	tex-custom = pkgs.texliveSmall.withPackages (ps: builtins.attrValues {
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

	vesktop = pkgs.vesktop.override {
		withTTS = false;
		withMiddleClickScroll = true;
	};

	awww = inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww;
	ags-bar = inputs.ags-bar.packages.${pkgs.stdenv.hostPlatform.system}.default;
	zen = inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default;
in {
	home.packages = builtins.attrValues {
		inherit
			ags-bar
			awww
			discord
			prism
			tex-custom
			vesktop
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
			alejandra
			alsa-utils
			anki
			aseprite
			btop
			darkly
			ffmpeg
			ffmpegthumbnailer
			fzf
			hyprshot
			keepassxc
			libnotify
			mpdas
			mpd-mpris
			mpv
			musicpresence
			nh
			nicotine-plus
			nil
			nodejs-slim
			obsidian
			openssl
			pavucontrol
			pinentry-qt
			picard
			playerctl
			pnpm
			qbittorrent
			qimgv
			ripgrep
			rmpc
			statix
			telegram-desktop
			unzip
			wl-clipboard
			xdg-utils
			xlsclients
			xwl-notifier
			yams
			zathura
			;
	};
}
