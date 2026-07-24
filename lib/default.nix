{ pkgs, self }: let
	inherit (pkgs) callPackage;
	lib = pkgs.lib;
in {
	recImport = callPackage ./recursiveImport.nix { inherit lib; };
	fromShared = callPackage ./importFromShared.nix { inherit self; };
}
