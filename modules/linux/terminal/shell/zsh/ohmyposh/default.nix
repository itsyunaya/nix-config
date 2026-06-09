{ osConfig, lib, ... }: let
	sh = osConfig.itsyunaya-nix.sh;
in {
	programs.oh-my-posh = lib.mkIf (sh.shell == "zsh" && sh.zshEnableExtraCustomization) {
		enable = true;
		enableZshIntegration = true;

		settings = builtins.fromJSON (builtins.readFile ./config.json);
	};
}
