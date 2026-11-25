{ promise, types, ... }: let
	default = "~/.ssh/id_ed25519.pub";
	keys = {
		juno = default;
		callisto = default;
		macbook = default;
	};
in {
	options = {
		settings.mutators = [ "/git" "/less" ];
		hostName.type = types.string;

		package.default = promise ({ inputs }: inputs.nixpkgs.pkgs.gitMinimal);
	};

	mutations = {
		"/git".settings = promise ({ options }: {
			user = {
				name = "itsyunaya";
				email = "git@itsyunaya.app";
				signingKey = keys.${options.hostName};
			};

			gpg.format = "ssh";
			commit.gpgsign = true;
			tag.gpgsign = true;

			init.defaultBranch = "main";
		});

		"/fish".abbreviations = {
			gs = "git status";
			gc = "git commit -v";
			gd = "git diff";
			gds = "git diff --staged";
			ga = "git add -A";
			gap = "git add --patch";
			gp = "git push";
		};
	};
}
