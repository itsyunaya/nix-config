{ config, lib, pkgs, ... }: let
	cfg = config.programs.latex;

	tex-custom = pkgs.texliveSmall.withPackages (ps:
			builtins.attrValues {
				inherit
					(ps)
					scheme-medium
					biber
					biblatex
					biblatex-bath
					circuitikz
					csquotes
					lastpage
					mdframed
					needspace
					pgfplots
					svg
					transparent
					wrapfig
					zref
					;
			});
in {
	options.programs.latex.enable = lib.mkEnableOption "LaTeX";

	config = lib.mkIf cfg.enable {
		environment.systemPackages = [ tex-custom ];
	};
}
