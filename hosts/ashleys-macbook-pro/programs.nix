{ inputs, pkgs, wrappers, ... }: let
	meowvim = inputs.meowvim.packages.${pkgs.stdenv.hostPlatform.system}.default;
in {
	environment.systemPackages = builtins.attrValues {
		inherit
			meowvim
			#vscode
			;

		inherit
			(pkgs)
			gnupg
			localsend
			pinentry_mac
			skimpdf
			;
	}
	++ [
		(wrappers.git { hostName = "macbook"; })
	];

	programs = {
		fish = {
			enable = true;
			package = wrappers.fish.drv;
			useBabelfish = true;
		};

		# since zsh is the default shell on macos, this is on by default
		# and needs to be disabled to not add unnecessary files
		zsh.enable = false;
	};
}
