# https://gerg-l.github.io/spicetify-nix/
{ tackInputs, pkgs, ... }: let
	spicePkgs = tackInputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in {
	programs.spicetify = {
		enable = true;
		enabledExtensions = with spicePkgs.extensions; [
			adblock
			shuffle
			groupSession
			volumePercentage
			aiBandBlocker
		];
	};
}
