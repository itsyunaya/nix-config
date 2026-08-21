{ config, pkgs, ... }: let
	inherit (pkgs.stdenv.hostPlatform) isDarwin;

	keys = {
		juno = "198EA594738FED19";
		callisto = "C3BC6629CF0FC433";
		macbook = "2E7FD19FA57EEAA4";
	};

	signKey =
		if isDarwin
		then keys.macbook
		else keys.${config.networking.hostName} or (throw ''
			Unrecognized machine '${config.networking.hostName}' imported git module.
			Please explicitly add a signing key for it to the module config.
		'');
in {
	environment = {
		systemPackages = [ pkgs.git ];
		# if this is unset git will not find the file because it is stupid
		variables."GIT_CONFIG_SYSTEM" = "/etc/gitconfig";
	};

	environment.etc."gitconfig".text = ''
		[commit]
			gpgsign = true

		[init]
			defaultBranch = "main"

		[tag]
			gpgSign = true

		[user]
			email = "40719746+itsyunaya@users.noreply.github.com"
			name = "itsyunaya"
			signingKey = "${signKey}"
	'';
}
