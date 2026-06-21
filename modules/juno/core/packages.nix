{ inputs, pkgs, self, ... }: {
	home.packages = builtins.attrValues {
		tex-custom = pkgs.texlive.combine {
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
		};

		discord = pkgs.discord.override {
			withVencord = true;
		};

		prism = pkgs.prismlauncher.override {
			# system glfw for running mc natively on wayland
			# only works for some versions up to 26.x
			additionalLibs = [ pkgs.glfw ];
		};

		awww = inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww;
		mp = pkgs.callPackage "${self}/packages/musicpresence.nix" {};
		zen = inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default;

		inherit
			(pkgs.jetbrains)
			clion
			idea
			webstorm
			;

		inherit
			(pkgs.kdePackages)
			dolphin
			kio
			kio-extras
			kio-fuse
			;

		inherit
			(pkgs)
			alejandra
			alsa-utils
			anki
			aseprite
			btop
			darkly
			devenv
			fd
			ffmpeg
			ffmpegthumbnailer
			fzf
			gcc
			glib
			haskell-language-server
			hyprshot
			keepassxc
			libnotify
			mpdas
			mpd-mpris
			mpv
			nh
			nicotine-plus
			nixd
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
			rustup
			statix
			telegram-desktop
			unrar
			unzip
			vesktop
			wl-clipboard
			xdg-utils
			xlsclients
			xwl-notifier
			yams
			zathura
			;
	};
}
