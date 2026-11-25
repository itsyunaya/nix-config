{ promise, ... }: {
	options = {
		settings.mutators = [ "/git" "/less" ];
		package.default = promise ({ inputs }: inputs.nixpkgs.pkgs.gitMinimal);
	};

	mutations = {
		"/git".settings = promise ({ options }: {
			user = {
				name = "itsyunaya";
				email = "git@itsyunaya.app";
				signingKey = "~/.ssh/id_ed25519.pub";
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
