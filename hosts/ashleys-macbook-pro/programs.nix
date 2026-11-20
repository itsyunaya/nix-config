{ inputs, pkgs, wrappers, ... }: let
	meowvim = inputs.meowvim.packages.${pkgs.stdenv.hostPlatform.system}.default;
in {
	environment.systemPackages = builtins.attrValues {
		inherit meowvim;

		inherit
			(pkgs)
			gnupg
			localsend
			pinentry_mac
			skimpdf
			;
	}
	++ [ (wrappers.git { hostName = "macbook"; }) ];

	programs = {
		# since zsh is the default shell on macos, this is on by default
		# and needs to be disabled to not add unnecessary files
		zsh.enable = false;
		bash.enable = false; # bash is also here for some reason
	};
}
