{
	explode = "poweroff";

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
	nrt = {
		expansion = "nix run git+https://tangled.org/%";
		setCursor = true;
	};
}
