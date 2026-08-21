{ pkgs, inputs, ... }: {
	programs = {
		gnupg.agent = {
			enable = true;
			enableSSHSupport = true;
			pinentryPackage = pkgs.pinentry-qt;
		};

		hyprland = {
			enable = true;
			package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
			portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

			xwayland.enable = true;
			withUWSM = true;
		};

		steam.enable = true;
		torrenting.enable = false;
	};
}
