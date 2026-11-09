# TODO: pr nix-darwin for this
{ config, lib, pkgs, ... }: let
	cfg = config.programs.tack;
in {
	options.programs.tack = {
		enable = lib.mkEnableOption "tack, flake-like toml nix pins";

		package = lib.mkPackageOption pkgs "tack" {};
	};

	config = lib.mkIf cfg.enable {
		environment.systemPackages = [ cfg.package ];
	};
}
