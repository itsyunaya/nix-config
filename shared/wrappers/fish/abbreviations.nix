{
	explode = "poweroff";

	# git
	gs = "git status";
	gc = "git commit -v";
	gd = "git diff --name-only --relative --diff-filter=d -z | xargs -0 bat --diff";
	ga = "git add -A";
	gap = "git add --patch";
	gp = "git push";

	nho = "nh os switch";
	nhd = "nh darwin switch";

	# nix
	ns = "nix shell";
	nr = "nix run";
	nrp = "nix repl";
	nrr = {
		expansion = "nix run nixpkgs#%";
		setCursor = true;
	};
	nb = {
		expansion = "nix build .#%";
		setCursor = true;
	};
}
