{ config, pkgs, ... }: {
	programs = {
		zsh.enable = true;

		#appimage.enable = true;
		#appimage.binfmt = true;

		hyprland.enable = config.juno-cfg.compositor == "hyprland";
		mango.enable = config.juno-cfg.compositor == "mango";

		anime-game-launcher.enable = true;
		steam.enable = true;

		gnupg.agent = {
			enable = true;
			enableSSHSupport = true;
			pinentryPackage = pkgs.pinentry-qt;
		};
	};
}
