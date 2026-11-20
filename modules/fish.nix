{ wrappers, ... }: {
	programs.fish = {
		enable = true;
		package = wrappers.fish.drv;
		useBabelfish = true;
	};
}
