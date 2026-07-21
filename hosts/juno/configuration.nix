{ theme, inputs, pkgs, self, lib, ... }: let
	username = "ashley";
	recImport = import "${self}/lib/recursiveImport.nix" { inherit lib; };
in {
	nix.settings.experimental-features = [
		"nix-command"
		"flakes"
	];

	juno-cfg = {
		# "swaylock" or "hyprlock"
		lock-app = "hyprlock";

		torrenting = false;
	};

	imports = [
		(recImport "${self}/hosts/juno/modules" { inherit username; })
	];

	hjem = {
		specialArgs = { inherit theme; };
		extraModules = [ (recImport "${self}/home/juno/modules") ];
		users.${username} = {
			files."wallpapers" = {
				source = "${self}/assets/wallpapers/";
				target = ".wallpapers";
			};

			imports = [ (recImport "${self}/home/juno/config") ];
		};
	};

	users.users.${username} = {
		isNormalUser = true;
		description = "${username}";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = [];
		shell = pkgs.zsh;

		# needs to be explicitly set for mpd
		uid = 1000;
	};

	environment = {
		systemPackages = let
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

			vesktop = pkgs.vesktop.override {
				withTTS = false;
				withMiddleClickScroll = true;
			};

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
					apfs-fuse
					aseprite
					btop
					cifs-utils
					darkly
					eza
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
					qimgv
					ripgrep
					statix
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

		sessionVariables = {
			QT_IM_MODULE = "fcitx";
			XMODIFIERS = "@im=fcitx";
			SDL_IM_MODULE = "fcitx";
			GLFW_IM_MODULE = "ibus";
			QT_QPA_PLATFORM = "wayland";
			NIXOS_OZONE_WL = "1";
		};
	};

	# state version should only be changed when it is really necessary,
	# as it can cause system breakage. for more info see
	# https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
	system.stateVersion = "25.11"; # Did you read the comment?
}
