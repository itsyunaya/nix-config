# recreation of import-tree's basic functionality
# since i dont need most of what it offers
{ lib, ... }: dir: let
	dirPath =
		if builtins.isAttrs dir && dir ? outPath
		then dir.outPath
		else dir;

	files = builtins.filter
	(file: let
			path = toString file;
		in
			lib.hasSuffix ".nix" path && !lib.hasInfix "/_" path)
	(lib.filesystem.listFilesRecursive dirPath);
in {
	imports = files;
}
