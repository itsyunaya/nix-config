{ promise, ... }: {
	inputs = {
		less.from = { parent }: parent.less;
	};

	options = {
		flags.default = promise ({ inputs }: let
			inherit (inputs.nixpkgs) lib;
			lessWrapper = inputs.less {};
		in [
			# the grid adds a lot of visual noise, especially in large diffs
			"--style=default,rule,-grid"
			"--pager=${lib.getExe lessWrapper}"
		]);
	};
}
