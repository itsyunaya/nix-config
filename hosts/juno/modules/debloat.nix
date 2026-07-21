{
	# no need for inbuilt docs when the reference manual is right there
	documentation = {
		enable = false;
		info.enable = false;
		nixos.enable = false;
		man.enable = false;
	};

	environment = {
		# perl, rsync, strace
		defaultPackages = [ ];

		# error message when trying to run dynamically linked exes
		stub-ld.enable = false;
	};

	programs.nano.enable = false;

	services.speechd.enable = false;

	system.tools = {
		nixos-enter.enable = false;
		nixos-generate-config.enable = false;
		nixos-install.enable = false;
	};
}
