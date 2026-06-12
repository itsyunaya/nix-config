{ theme, inputs, config, pkgs, lib, self, ... }: let
	username = "ashley";
	hm = config.home-manager.users.${username};
in {
	nix.settings.experimental-features = [
		"nix-command"
		"flakes"
	];

	itsyunaya-nix = {
		/*
		CAUTION: changing this always requires a reboot, and should only be performed
		from tty. If the compositor is running while its file gets removed by home-manager,
		it might fall back to a default one which needs to be removed manually
		since hm can't overwrite it anymore at that point
		*/
		# "mango" or "hyprland"
		compositor = "hyprland";

		sh = {
			# "zsh" or "nushell"
			shell = "zsh";
			# this option enables/disables omz/omp if zsh is set as the active shell.
			# can improve init times by a good margin
			zshEnableExtraCustomization = true;
		};

		# "swaylock" or "hyprlock"
		lock-app = "hyprlock";
		# "kitty" or "ghostty"
		terminal = "kitty";
	};

	home-manager = {
		useGlobalPkgs = true;
		useUserPackages = true;
		extraSpecialArgs = { inherit inputs theme self username; };

		users.${username} = import ./home.nix;
	};

	fonts = {
		packages = builtins.attrValues {
			inherit (pkgs)
			noto-fonts
			noto-fonts-cjk-sans
			noto-fonts-cjk-serif
			liberation_ttf

			noto-fonts-color-emoji
			twemoji-color-font;

			inherit (pkgs.nerd-fonts) jetbrains-mono;
        };

		fontconfig = {
			defaultFonts = {
				sansSerif = [ "Noto Sans" "Noto Sans CJK JP" ];
				serif = [ "Noto Serif" "Noto Serif CJK JP" ];
				emoji = [ "Noto Color Emoji" "Twitter Color Emoji" ];
			};

			useEmbeddedBitmaps = true;
		};
	};

	# these have to be enabled on a systemwide level
	# i forgot why, but my old config had it so im keeping it :>
	programs = {
		zsh.enable = config.itsyunaya-nix.sh.shell == "zsh";

		appimage.enable = true;
		appimage.binfmt = true;

		hyprland.enable = true;
		#mango.enable = true;
		niri.enable = true;

		anime-game-launcher.enable = true;

		qtengine = {
			enable = true;

			config = {
				theme = {
					colorScheme = "${pkgs.kdePackages.breeze}/share/color-schemes/BreezeDark.colors";
					style = "darkly";

					font = {
						family = "Sans Serif";
						size = 11;
						weight = -1;
					};
				};

				misc = {
					singleClickActivate = false;
					menusHaveIcons = false;
					shortcutsForContextMenus = true;
				};
			};
		};
	};

	# qtengine iconTheme does not work so i have to use this instead :c
	environment.etc."xdg/kdeglobals".text = ''
		[Icons]
		Theme=WhiteSur-dark
	'';

	boot = {
		loader.systemd-boot.enable = true;
		loader.efi.canTouchEfiVariables = true;
		kernelPackages = pkgs.linuxPackages_latest;

		# needed so i can crosscompile rebuilds for ceres since
		# otherwise it will be awfully slow
		binfmt.emulatedSystems = [ "aarch64-linux" ];
	};

	nix.settings.secret-key-files = [ "/etc/nix/signing-key.sec" ];

	networking = {
		hostName = "juno";
		wireless.enable = true; # Enables wireless support via wpa_supplicant.
		networkmanager.enable = true;
	};

	time.timeZone = "Europe/Berlin";

	i18n = {
		defaultLocale = "en_US.UTF-8";
		extraLocaleSettings = {
        	LC_ADDRESS = "de_DE.UTF-8";
        	LC_IDENTIFICATION = "de_DE.UTF-8";
        	LC_MEASUREMENT = "de_DE.UTF-8";
        	LC_MONETARY = "de_DE.UTF-8";
        	LC_NAME = "de_DE.UTF-8";
        	LC_NUMERIC = "de_DE.UTF-8";
        	LC_PAPER = "de_DE.UTF-8";
        	LC_TELEPHONE = "de_DE.UTF-8";
        	LC_TIME = "de_DE.UTF-8";
        };

        inputMethod = {
        	enable = true;
        	type = "fcitx5";
        	fcitx5.waylandFrontend = true;
        	fcitx5.addons = with pkgs; [
        		fcitx5-mozc
        		fcitx5-gtk
        	];
        };
	};

	users.users.${username} = {
		isNormalUser = true;
		description = "${username}";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = [];
		shell =
			if config.itsyunaya-nix.sh.shell == "zsh"
			then pkgs.zsh
			else pkgs.nushell;
	};

	nixpkgs.config.allowUnfree = true;

	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.systemPackages = builtins.attrValues {
		inherit (pkgs)
		alejandra
		apfs-fuse
		cifs-utils
		darkly
		devenv
		docker-compose
		ffmpeg
		ffmpegthumbnailer
		gcc
		glib
		libnotify
		mpd-mpris
		mpv
		nh
		nixd
		nodejs
		openssl
		pinentry-qt
		playerctl
		pnpm
		qimgv
		rustup
		samba
		statix
		unrar
		unzip
		vim
		wget
		whitesur-cursors
		whitesur-icon-theme
		wl-clipboard
		xdg-utils
		zathura
		;

		qt6-qtwayland = pkgs.qt6.qtwayland;
		qt5-qtwayland = pkgs.qt5.qtwayland;

		qtsvg6 = pkgs.kdePackages.qtsvg;
		qtsvg5 = pkgs.libsForQt5.qt5.qtsvg;

		inherit (pkgs.kdePackages)
		dolphin;

		inherit (inputs.awww.packages.${pkgs.stdenv.hostPlatform.system})
		awww;
	};

	environment.sessionVariables = {
		QT_IM_MODULE = "fcitx";
		XMODIFIERS = "@im=fcitx";
		SDL_IM_MODULE = "fcitx";
		GLFW_IM_MODULE = "ibus";
		QT_QPA_PLATFORM = "wayland";
		NIXOS_OZONE_WL = "1";
	};

	virtualisation.podman = {
		enable = true;
		dockerCompat = true;
	};

	services = {
		xserver = {
			xkb = {
				layout = "us";
				variant = "";
			};

			videoDrivers = [ "nvidia" ];
		};

		samba.enable = true;

		displayManager.ly.enable = true;

		mullvad-vpn = {
        	enable = true;
        	package = pkgs.mullvad-vpn;
        };

        # needed for mullvad
        resolved.enable = true;

        pipewire = {
        	enable = true;
        	alsa.enable = true;
        	alsa.support32Bit = true;
        	pulse.enable = true;
        	jack.enable = true;
        	wireplumber.enable = true;
        };
	};

	programs.gnupg.agent = {
		enable = true;
		enableSSHSupport = true;
		pinentryPackage = pkgs.pinentry-qt;
	};

	# enable the little stars when typing my password (useful because im bad at typing :p)
	security.sudo.extraConfig = ''
    	Defaults env_reset,pwfeedback
	'';

	# needed so the screen lockers can actually validate my password
	# modular setup depending on which lock is in use
	security.pam.services =
		lib.optionalAttrs hm.programs.swaylock.enable { swaylock = {}; }
		// lib.optionalAttrs hm.programs.hyprlock.enable { hyprlock = {}; };

	hardware = {
		graphics = {
        	enable = true;
        	enable32Bit = true;
        };

        nvidia = {
        	modesetting.enable = true;
        	open = false;
        	nvidiaSettings = true;
        };

    	# makes my bluetooth not explode hopefully
        firmware = [ pkgs.linux-firmware ];

        bluetooth = {
        	enable = true;
        	powerOnBoot = true;
        	settings.General = {
        		Experimental = true;
        		FastConnectable = true;
        	};
        };
	};

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "25.11"; # Did you read the comment?
}
