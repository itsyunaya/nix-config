{ osConfig, ... }: let
	shell = osConfig.itsyunaya-nix.sh.shell;
in {
	programs.keychain = {
		enable = true;
		enableZshIntegration = shell == "zsh";
		enableNushellIntegration = shell == "nushell";

		extraFlags = [ "--quiet" "--noask" ];
		keys = [
			"id_ed25519"
			"id_ed25519_cl"
			"ceres_key"
		];

	};
}
