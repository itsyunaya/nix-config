{ pkgs, inputs }: let
	adios = inputs.adios.adios;
	adios-wrappers = import inputs.adios-wrappers { inherit adios; };

	root = {
		modules = adios.lib.inject [
			adios-wrappers
			(adios.lib.importModules { directory = ./.; })
		];
	};

	tree = adios root {
		options = {
			"/nixpkgs" = { inherit pkgs; };
			"/self" = { sysInputs = inputs; };
		};
	};
in
	# add drv for every wrapper which lets you shorthand call it,
	# useful for when no extra values need to be passed to the module
	builtins.mapAttrs (_: wrapper: wrapper // { drv = wrapper {}; }) tree.modules
