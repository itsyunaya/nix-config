{ inputs, pkgs }: let
	scenefx = pkgs.callPackage ./scenefx.nix { inherit (inputs) scenefx-src; };
	mango = pkgs.callPackage "${inputs.mango-src}/nix/default.nix" { inherit scenefx; };
in
	mango
