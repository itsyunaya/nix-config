{ config, pkgs, ... }: {
	programs = {
		zsh.enable = true;

		hyprland.enable = config.juno-cfg.compositor == "hyprland";
		#mango.enable = config.juno-cfg.compositor == "mango";

		steam.enable = true;

		gnupg.agent = {
			enable = true;
			enableSSHSupport = true;
			pinentryPackage = pkgs.pinentry-qt;
		};
	};
}
