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
			package = wrappers.mangowc.drv;
		};

		steam.enable = true;

		# custom modules
		torrenting.enable = false;
		latex.enable = false;
	};
}
