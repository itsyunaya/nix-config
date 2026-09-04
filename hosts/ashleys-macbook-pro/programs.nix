{ inputs, pkgs, wrappers, ... }: let
	pixel-berry-theme = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
		mktplcRef = {
			name = "pixel-berry";
			publisher = "germainelry";
			version = "0.1.3";
			sha256 = "sha256-Jrs8BPY/d6F/lbyc9YcVlYON7ZirBApgzG3Tws9jaME=";
		};
	};

	# this sucks a bit since the hjem module for it is *right there*, but i can't properly add it to my packages
	# because linking to users.packages (what hjem does) doesn't add it to Applications/
	vscode = pkgs.vscode-with-extensions.override {
		vscode = pkgs.vscodium;
		vscodeExtensions = with pkgs.vscode-extensions; [
			jnoortheen.nix-ide
			pixel-berry-theme
			haskell.haskell
			justusadam.language-haskell
		];
	};

	meowvim = inputs.meowvim.packages.${pkgs.stdenv.hostPlatform.system}.default;
in {
	environment.systemPackages = builtins.attrValues {
		inherit
			meowvim
			vscode
			;

		inherit
			(pkgs)
			gnupg
			localsend
			pinentry_mac
			skimpdf
			;
	} ++ [
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
