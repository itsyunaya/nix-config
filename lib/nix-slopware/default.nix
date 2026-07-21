{ lib }: let
	slopPkgs = import ./slop-packages.nix;
	slopPkgsByName = builtins.groupBy (a: a.name) slopPkgs;
in
	packages:
		builtins.foldl'
		(
			acc: pkg: let
				pkgName = lib.getName pkg;
				matches = slopPkgsByName.${pkgName} or [];
			in
				builtins.foldl'
				(
					acc': entry:
						builtins.throw
						"package '${pkgName}' matched as AI slop (categories: ${builtins.concatStringsSep ", " entry.categories})"
						acc'
				)
				acc
				matches
		)
		packages
		packages
