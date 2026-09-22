{ types, ... }: let
	keys = {
		juno = "6A161336141B9F44";
		callisto = "C3BC6629CF0FC433";
		macbook = "2E7FD19FA57EEAA4";
	};
in {
	options = {
		settings.mutators = [ "/git" "/less" ];
		hostName.type = types.string;

		package.defaultFunc = { inputs }: inputs.nixpkgs.pkgs.git.override { perlSupport = false; };
	};

	mutations."/git".settings = { options }: {
		user = {
			name = "itsyunaya";
			email = "40719746+itsyunaya@users.noreply.github.com";
			signingKey = keys.${options.hostName};
		};

		commit.gpgsign = true;
		tag.gpgsign = true;

		init.defaultBranch = "main";
	};
}
