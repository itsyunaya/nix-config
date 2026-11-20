{ pkgs, wrappers, ... }: {
	programs = {
		fuse.userAllowOther = true;

		gnupg.agent = {
			enable = true;
			enableSSHSupport = true;
			pinentryPackage = pkgs.pinentry-qt;
		};

		mango = {
			enable = true;
			package = wrappers.mango.drv;
		};

		steam.enable = true;
	};

	xdg.portal = {
		enable = true;
		wlr = {
			enable = true;
		};
	};
}
