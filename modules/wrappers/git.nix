{ promise, types, ... }: let
	keys = {
		juno = "23D5842B2455388D";
		callisto = "C3BC6629CF0FC433";
		macbook = "2E7FD19FA57EEAA4";
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

			commit.gpgsign = true;
			tag.gpgsign = true;

			init.defaultBranch = "main";
		});

		"/fish".abbreviations = {
			gs = "git status";
			gc = "git commit -v";
			gd = "git diff --name-only --relative --diff-filter=d -z | xargs -0 bat --diff";
			ga = "git add -A";
			gap = "git add --patch";
			gp = "git push";
		};
	};
}
