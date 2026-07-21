{ inputs, pkgs, ... }: {
	programs = {
		git = {
			enable = true;
			config = {
				commit.gpgsign = true;
				tag.gpgSign = true;
				init.defaultBranch = "main";

				user = {
					name = "itsyunaya";
					email = "40719746+itsyunaya@users.noreply.github.com";
					signingKey = "198EA594738FED19";
				};
			};
		};

		hyprland = {
			enable = true;
			package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
			portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

			xwayland.enable = true;
		};
		#mango.enable = config.juno-cfg.compositor == "mango";

		steam.enable = true;

		gnupg.agent = {
			enable = true;
			enableSSHSupport = true;
			pinentryPackage = pkgs.pinentry-qt;
		};
	};
}
