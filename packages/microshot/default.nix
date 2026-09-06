{ pkgs }:
pkgs.writeShellApplication {
	name = "microshot";
	text = builtins.readFile ./microshot.sh;

	runtimeInputs = builtins.attrValues {
		inherit
			(pkgs)
			grim
			libnotify
			satty
			slurp
			wayfreeze
			wl-clipboard
			;
	};

	meta = {
		description = "Small screenshot tool";
	};
}
