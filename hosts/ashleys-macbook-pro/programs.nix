{ inputs, pkgs, wrappers, ... }: let
	meowvim = inputs.meowvim.packages.${pkgs.stdenv.hostPlatform.system}.default;
	git = wrappers.git.drv;
in {
	environment.systemPackages = builtins.attrValues {
		inherit git meowvim;

		inherit
			(pkgs)
			gnupg
			localsend
			pinentry_mac
			skimpdf
			;
	};

	programs = {
		# since zsh is the default shell on macos, this is on by default
		# and needs to be disabled to not add unnecessary files
		zsh.enable = false;
		bash.enable = false; # bash is also here for some reason
	};
}
