# recreation of import-tree's basic functionality
# since i dont need most of what it offers
{ lib, ... }: let
	inherit (lib) hasInfix hasSuffix;
	inherit (builtins) filter isString;
in
	dir: let
		dirPath =
			if isString dir
			then builtins.toPath dir
			else dir;

		files = filter
		(file: let
				path = toString file;
			in
				hasSuffix ".nix" path && !hasInfix "/_" path)
		(lib.filesystem.listFilesRecursive dirPath);
	in {
		imports = files;
	}
