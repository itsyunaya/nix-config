# recreation of import-tree's basic functionality
# since i dont need most of what it offers
{ lib }: dir: extraArgs: let
	dirPath = if builtins.isAttrs dir && dir ? outPath
	then dir.outPath
	else dir;

	root = toString dirPath;

	files = builtins.filter (
		file: let
			rel = lib.removePrefix "${root}/" (toString file);
		in
			lib.hasSuffix ".nix" rel
			&& rel != "default.nix"
	)
	(lib.filesystem.listFilesRecursive dirPath);
in {
	imports = files;
	_module.args = extraArgs;
}
