{ self }: let
	importFromShared = modules: builtins.map (mod: "${self}/shared/${mod}") modules;
in
	importFromShared
