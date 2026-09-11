{ pkgs, inputs, wrappers, ... }: {
	programs = {
		direnv = {
			enable = true;
			silent = true;
			nix-direnv.enable = true;
		};

		fish = {
			enable = true;
			package = wrappers.fish.drv;
			useBabelfish = true;
		};

		gnupg.agent = {
			enable = true;
			enableSSHSupport = true;
			pinentryPackage = pkgs.pinentry-qt;
		};

		hyprland = {
			enable = false;
			package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
			portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

			xwayland.enable = true;
			withUWSM = true;
		};

		mango = {
			enable = true;
			#package = wrappers.mangowc.drv;
			package = inputs.mango.packages.${pkgs.stdenv.hostPlatform.system}.mango;
		};

		steam.enable = true;

		# custom modules
		torrenting.enable = false;
		latex.enable = false;
	};

	xdg.portal = {
		enable = true;
		wlr = {
			enable = true;
			settings.screencast = {
				chooser_type = "dmenu";
				chooser_cmd = "${wrappers.noctalia.drv}/bin/noctalia dmenu";
			};
		};
	};
}
