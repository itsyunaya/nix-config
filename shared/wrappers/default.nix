{ pkgs, tackInputs, ... }: let
	adios = tackInputs.adios.adios;
	adios-wrappers = import tackInputs.adios-wrappers { inherit adios; };

	root = {
		modules = adios.lib.inject [
			adios-wrappers
			(adios.lib.importModules { directory = ./.; })
		];
	};

	tree = adios root {
		options = {
			"/nixpkgs" = {
				inherit pkgs;
			};
		};
	};
in
	builtins.mapAttrs (_: module: module {}) tree.modules
