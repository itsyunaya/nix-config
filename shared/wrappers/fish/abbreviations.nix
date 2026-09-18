{
	explode = "poweroff";

	# git
	gs = "git status";
	gc = "git commit -v";
	gd = "git diff --name-only --relative --diff-filter=d -z | xargs -0 bat --diff";
	ga = "git add -A";
	gap = "git add --patch";
	gp = "git push";

	# nix
	ns = "nix shell";
	nr = {
		expansion = "nix run nixpkgs#%";
		setCursor = true;
	};
	nrp = "nix repl";
	nb = {
		expansion = "nix build .#%";
		setCursor = true;
	};
}
