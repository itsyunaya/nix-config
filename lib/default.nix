{ pkgs, self }: let
	inherit (pkgs) callPackage lib;
in {
	recImport = callPackage ./recursiveImport.nix { inherit lib; };
	fromShared = callPackage ./importFromShared.nix { inherit self; };
}
