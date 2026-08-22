/*
	The reason this Flake exists, is because upstream chose to use flake-parts
	in their Flake, which results in a noticeable (rebuild) performance loss with
	little to no benefits.
*/

{
	description = "Mango Flake";

	inputs = {
		# overridden with follows
		nixpkgs = {};

		mango = {
			url = "github:mangowm/mango";
			flake = false;
		};

		scenefx = {
			url = "github:wlrfx/scenefx";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, mango, ... }: let
		systems = [
			"x86_64-linux"
			"aarch64-linux"
		];

		forAllSystems = f: nixpkgs.lib.genAttrs systems f;
	in {
		packages = forAllSystems (system: let
			pkgs = import nixpkgs { inherit system; };
			mango-pkg = pkgs.callPackage "${mango}/nix/default.nix" { };
		in {
			mango = mango-pkg;
			default = mango-pkg;
		});

		nixosModules.mango = import "${mango}/nix/nixos-modules.nix" self;
	};
}
